# Homework #3: Arpeggiator and Beyond

The goal of this homework is to make an arpeggiator using Chuck and design a new musical interaction 

*** Renting a MIDI Keyboard: [link](https://docs.google.com/spreadsheets/d/19JWFxTN6xlDoAZzQVOw6WNCjx2etJlLZmvo3hrB3Sj8/edit?usp=sharing
) ***

## Due date and deliverables
- **Nov 26, 11:59pm**
- Source code file (.ck) 
- A short report (.pdf): describe what you implemented and performed
- A video file of your performance (.mp4): this video should include your play and the sound. You can use your smartphone to record the video.
- Submit them to KLMS

## Step #1: Read/Watch the following background resources and understand the arppegiator
- [Arpeggiators Explained: 7 Creative Ways to Use Arps in Your Tracks (Landr)](https://blog.landr.com/arpeggiators/)
- [What Is an Arpeggiator? (Sweetwater) ](https://www.youtube.com/watch?v=7sHx3sA0aGk)
- [How To Use The Arpeggiator (Arturia)](https://www.youtube.com/watch?v=ZAFDPG8ewGo)

## Step #2: Run the baseline code 
- We provide the two types of baseline source code in Chuck: [poly-key-arp.ck](https://github.com/juhannam/ctp431-2023/blob/main/hw3/poly-key-arp.ck) (keyboard version) and [poly-midi-arp.ck](https://github.com/juhannam/ctp431-2023/blob/main/hw3/poly-midi-arp.ck) (MIDI version)
- Run the Chuck files and understand how they work

## Step #3: Customize the baseline code (60 pts)
Implement the following arpeggiator patterns
- Note order: up, down, updown, playorder (by the order of play), random  
- Note range: +1 octave, +2 octaves
- Swing: 66% (divide 1 beat into 2/3 beat, 1/3 beat), 75% (divide 1 beat into 3/4 beat, 1/4 beat)  

## Step #4: Add more nuances and flavors (30 pts)
- Change the syntheised tone using different combinations of OSC, Filter, and Amp Envelope. Or, you can also use recorded samples.
- Map a knob of the MIDI controller or your keyboard (e.g. 0-9 number keys) to change the tempo in BPM 
- Add a global resonant lowpass filter and LFO to to change the cut-off frequency automatically (the frequency of LFO can be synchronized to the tempo). Alternatively, you can map a knob of the MIDI controller to change the cut-off frequency  (See: https://www.youtube.com/watch?v=BZqqjshJGq0 (Filter) and https://www.youtube.com/watch?v=ikReJ0i1zjE (LFO))
- Add a delay effect (the delay time can be synchronized to the tempo) (See: https://www.youtube.com/watch?v=Rl2Go06u7CM)
- You can implement more advanced options of arpeggiator such as gate, latch, chord or other creative patterns
- You can even add another track, for example, a drum track along with the arpeggiator track

## Step #5: Record your play (10 pts)
- Play your favorite arpegiator pattern and record it as a video





