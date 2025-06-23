package com.toad.plugin.jmeter.functions;

import org.apache.jmeter.engine.util.CompoundVariable;
import org.apache.jmeter.functions.AbstractFunction;
import org.apache.jmeter.functions.InvalidVariableException;
import org.apache.jmeter.samplers.SampleResult;
import org.apache.jmeter.samplers.Sampler;
import org.apache.jmeter.threads.JMeterVariables;


import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

public class AddInt extends AbstractFunction {
//    private static final Logger log = LoggerFactory.getLogger(AddInt.class);
    //显示的参数名字
    private static final List<String> desc = new LinkedList<>();
    static {
        desc.add("First int");
        desc.add("Second int");
        desc.add("Third int");
        desc.add("Result Int");
    }
    /**
     * 显示的函数名字
     */
    private static final String KEY = "__AddInt";
    /**
     * 参数值
     */
    private Object[] values;

    @Override
    public String execute(SampleResult sampleResult, Sampler sampler) throws InvalidVariableException {
        JMeterVariables localJMeterVariables = getVariables();
        //第一个整数
        String firstInt = ((CompoundVariable)this.values[0]).execute();
        //第二个整数
        String secondInt = ((CompoundVariable)this.values[1]).execute();
        //第三个整数
        String thirdInt = ((CompoundVariable)this.values[2]).execute();
        String sumString = "";
        int a = 0;
        int b = 0;
        int c = 0;
        try {
            a = Integer.parseInt(firstInt);
            b = Integer.parseInt(secondInt);
            c = Integer.parseInt(thirdInt);
            sumString = Integer.toString(this.addInt(a, b, c));
        } catch (NumberFormatException e) {
//            log.error(e.toString());
        }
        if ((localJMeterVariables != null) && (this.values.length > 0)) {
            localJMeterVariables.put(((CompoundVariable)this.values[values.length - 1]).execute(), sumString);
        }
        return sumString;
    }

    //设置参数值
    @Override
    public void setParameters(Collection<CompoundVariable> collection) throws InvalidVariableException {
        checkMinParameterCount(collection, 3);
        checkParameterCount(collection, 3);
        this.values = collection.toArray();
    }

    //返回函数名字
    @Override
    public String getReferenceKey() {
        return KEY;
    }

    //返回参数名字
    @Override
    public List<String> getArgumentDesc() {
        return desc;
    }

    public int addInt(int a, int b, int c) {
        return a + b + c;
    }
}