package com.retail.analysis;

import java.io.IOException;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Mapper;

public class CategoryProfitMapper
        extends Mapper<LongWritable, Text, Text, DoubleWritable> {

    private Text category = new Text();

    public void map(LongWritable key, Text value, Context context)
            throws IOException, InterruptedException {

        String line = value.toString();

        if (line.startsWith("Ship Mode"))
            return;

        String[] fields = line.split(",");

        try {
            String categoryName = fields[7].trim();
            double profit = Double.parseDouble(fields[12].trim());

            category.set(categoryName);
            context.write(category, new DoubleWritable(profit));

        } catch (Exception e) {
        }
    }
}
