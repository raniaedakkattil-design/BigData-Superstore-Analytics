package com.retail.analysis;

import java.io.IOException;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Mapper;

public class RegionSalesMapper
        extends Mapper<LongWritable, Text, Text, DoubleWritable> {

    private Text region = new Text();

    public void map(LongWritable key, Text value, Context context)
            throws IOException, InterruptedException {

        String line = value.toString();

        if (line.startsWith("Ship Mode"))
            return;

        String[] fields = line.split(",");

        try {
            String regionName = fields[6].trim();
            double sales = Double.parseDouble(fields[9].trim());

            region.set(regionName);
            context.write(region, new DoubleWritable(sales));

        } catch (Exception e) {
        }
    }
}
