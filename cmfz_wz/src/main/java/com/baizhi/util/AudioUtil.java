package com.baizhi.util;

import it.sauronsoftware.jave.Encoder;
import it.sauronsoftware.jave.EncoderException;
import it.sauronsoftware.jave.MultimediaInfo;

import java.io.File;

public class AudioUtil {
    public static long getAudioLength(File file) throws EncoderException {
        Encoder encoder = new Encoder();
        MultimediaInfo m = encoder.getInfo(file);
        long ls = m.getDuration() / 1000;
        return ls;
    }
}
