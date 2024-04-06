
import numpy as np
from pydub import AudioSegment
from pydub.playback import play
import time

def generate_tone(frequency, duration_ms=1000):
    """Generate a sine wave tone"""
    sample_rate = 44100
    samples = (np.sin(2 * np.pi * np.arange(sample_rate * duration_ms / 1000) * frequency / sample_rate)).astype(np.float32)
    audio = AudioSegment(samples.tobytes(), frame_rate=sample_rate, sample_width=2, channels=1)
    return audio

frequency = 440 

try:
    while True:
        frequency *= 1.01
        if frequency > 10000:
            frequency = 440

        tone = generate_tone(frequency)
        play(tone)

        time.sleep(0.1)
except KeyboardInterrupt:
    print("Stopped")
