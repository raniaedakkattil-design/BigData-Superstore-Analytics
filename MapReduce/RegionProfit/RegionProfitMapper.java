package com.retail.analysis;

import java.io.IOException;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class RegionProfitMapper extends Mapper<LongWritable, Text, Text, DoubleWritable> {

    private Text region = new Text();
    private DoubleWritable profit = new DoubleWritable();

    @Override
    protected void map(LongWritable key, Text value, Context context)
            throws IOException, InterruptedException {

        String line = value.toString();

        // Skip header
        if (line.startsWith("Ship Mode"))
            return;

        String[] fields = line.split(",");

        try {
            String regionName = fields[6].trim();
            double profitValue = Double.parseDouble(fields[12].trim());

            region.set(regionName);
            profit.set(profitValue);

            context.write(region, profit);

        } catch (Exception e) {
            // Ignore malformed records
        }
    }
}
