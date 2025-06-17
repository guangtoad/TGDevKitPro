package com.toad.java.tgmeter.functions;

import org.apache.jmeter.engine.util.CompoundVariable;
import org.apache.jmeter.functions.AbstractFunction;
import org.apache.jmeter.functions.InvalidVariableException;
import org.apache.jmeter.samplers.SampleResult;
import org.apache.jmeter.samplers.Sampler;
import org.apache.jmeter.threads.JMeterVariables;
import org.apache.jmeter.util.JMeterUtils;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

public class MobileFunction extends AbstractFunction {
        /** function名称 */

                private static final String KEY = "__testMobile";

    private static final List<String> desc = new LinkedList<String>();

    private static final String[] telFirst = "134,135,136,137,138,139,150,151,152,157,158,159,130,131,132,155,156,133,153".split(",");

    /** function描述  */

            static {

        desc.add(JMeterUtils.getResString("derrick test"));

    }

    private CompoundVariable varName;

    /** 执行部分 */

            @Override

    public String execute(SampleResult

                                  previousResult, Sampler currentSampler) throws InvalidVariableException {

        int index =getNum(telFirst.length - 1);

        String first = telFirst[index];

        String second = String.valueOf(getNum(999) + 10000).substring(1);

        String third = String.valueOf(getNum(9990) + 10000).substring(1);

        String mobile = first + second + third;



        if(varName != null) {

            JMeterVariables vars =getVariables();

            final String varTrim = varName.execute().trim();

            if(vars != null && varTrim.length() > 0) {

                vars.put(varTrim, mobile);

            }

        }

        return mobile;

    }

    /** 设置参数 */

            @Override

    public void setParameters(Collection<CompoundVariable> parameters) throws InvalidVariableException{

        checkParameterCount(parameters, 0, 1);

        Object[] values = parameters.toArray();

        if(values.length > 0) {

            varName =

                    (CompoundVariable) values[0];

        } else {

            varName = null;

        }

    }

    @Override

    public String getReferenceKey() {

        return KEY;

    }

    @Override

    public List<String>getArgumentDesc() {

        return desc;

    }

    private static int getNum(int end) {

        return (int) (Math.random() *(end -1));

    }
}
