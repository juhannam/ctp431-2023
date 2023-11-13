// the human interface device
Hid hi;
// the message for retrieving data
HidMsg msg;

if( !hi.openKeyboard(0) ) me.exit();

// print out device that was opened
<<< "keyboard '" + hi.name() + "' ready", "" >>>;

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
    // wait on the keyboard event 
    hi => now;
    
    // get the message(s)
    while( hi.recv(msg) && msg.which != 29 ) // ignore ctrl key
    {
        if ( msg.isButtonDown() )
        {
            <<< "down:", msg.which, "(code)", msg.key, "(usb.key)", msg.ascii, "(ascii)" >>>;
            1 => noteStatus[msg.ascii];
            <<< "note on : " + msg.ascii + " " + noteStatus[msg.ascii] >>>;
        }
        else if ( msg.isButtonUp() ) 
        {
            0 => noteStatus[msg.ascii];            
            <<< "note off: " +msg.ascii + " " + noteStatus[msg.ascii] >>>;
        }          
    }
} 

