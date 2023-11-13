// the midi event
MidiIn midi;
// the message for retrieving data
MidiMsg msg;


// number of the device to open (see: chuck --probe)
0 => int device;
// get command line
if( me.args() ) me.arg(0) => Std.atoi => device;
// open the device
if( !midi.open( device ) ) me.exit();

// print out device that was opened
<<< "MIDI device:", midi.num(), " -> ", midi.name() >>>;

// make our own event
class NoteEvent extends Event
{
    int note;
    int velocity;
}

// the event
NoteEvent on;

// signal chain
JCRev rev => dac;
0.01 => rev.mix;


fun void PlayBeep(int key)
{
    SinOsc osc => ADSR env1 => rev;
    0.5 => osc.gain; 
    (1::ms, 200::ms, 0.0, 1::ms) => env1.set;
    
    key => Std.mtof => osc.freq;
    1 => env1.keyOn;
    200::ms => now;
    1 => env1.keyOff;      
}


// Arpeggiator
120.0 => float tempo;
int noteStatus[128];

// define tick
1::ms => dur tick;
1000/(tempo/60.0)/4 => float quarterTempoInTick;

fun void Arpeggiator()
{
    0 => int i;
    0 => int noteCount;
    while (true)
    {
        if (noteStatus[i] == 1) 
        {
            spork ~ PlayBeep(i);
            quarterTempoInTick*tick => now;  
            ++noteCount;
        }
        
        // reset
        if (++i == 128) 
        {
            // if no notes were played, just advance time by the quarter beat (do nothing)
            if (noteCount == 0)
            {
                quarterTempoInTick*tick => now; 
            }
            0 => noteCount;
            0 => i;            
        }
    }
}

spork ~ Arpeggiator();


// infinite time-loop
while( true )
{
    // wait on the MIDI event
    midi => now;
    
    // get the message(s)
    while( midi.recv(msg) )
    {
        // print out midi message
        <<< msg.data1, msg.data2, msg.data3 >>>;
        
        // note on
        if( (msg.data1 & 0xf0) == 0x90 ) 
        {
            1 => noteStatus[msg.data2];
            <<< "note on : " + msg.data2 + " " + noteStatus[msg.data2] >>>;
        }
        // note off
        else if ( (msg.data1 & 0xf0) == 0x80 ) 
        {
            0 => noteStatus[msg.data2];            
            <<< "note off: " + msg.data2 + " " + noteStatus[msg.data2] >>>;
        }        
    }
} 