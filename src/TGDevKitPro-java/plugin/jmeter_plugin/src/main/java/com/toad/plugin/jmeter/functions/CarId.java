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

public class CarId extends AbstractFunction {

    private static final List<String> desc = new LinkedList<>();

    /**在函数助手中的显示名称**/

    private static final String KEY = "__CarId";

    static{

        //函数参数-省份简称

        desc.add(JMeterUtils.getResString("Province_param"));

        //函数参数-市级ID

        desc.add(JMeterUtils.getResString("CityId_param"));

        desc.add(JMeterUtils.getResString("function_name"));

    }

    private CompoundVariable Province_param;

    private CompoundVariable CityId_param;

    private CompoundVariable varName;

    @Override

    public List<String>getArgumentDesc() {

        return desc;

    }

    @Override

    public String execute(SampleResult

                                  previousResult, Sampler currentSampler) throws InvalidVariableException{

        //获取所输入参数-省级简称

        String province = Province_param.execute().trim();

        //获取所输入参数-市级ID

        String city = CityId_param.execute().trim();

        //实现逻辑不变

        char[] license = new char[5];

        int i = 0;

        int k = 0;

        int n = 0;

        for(; i < 5; i++) {

            if (Math.random() >0.5) {

                if (k < 3) {

                    license[i] = (char) ('A' + Math.random() *26);

                    k++;

                } else {

                    license[i] = (char) ('0' + Math.random() *10);

                    n++;

                }

            }else {

                if (n < 4) {

                    license[i] = (char) ('0' + Math.random() *10);

                    n++;

                } else {

                    license[i] = (char) ('A' + Math.random() *26);

                    k++;

                }

            }

        }

        String licenses = String.valueOf(license);

        String carId = province+city+licenses;

        if(varName != null) {

            JMeterVariables vars =getVariables();

            final String varTrim = varName.execute().trim();

            if(vars != null && varTrim.length() > 0) {

                vars.put(varTrim, carId);

            }

        }

        return carId;

    }

    @Override

    public void setParameters(Collection<CompoundVariable> parameters) throws InvalidVariableException {

        checkParameterCount(parameters, 2, 3);

        Object[] values = parameters.toArray();

        Province_param =

                (CompoundVariable) values[0];

        CityId_param =

                (CompoundVariable) values[1];

        if(values.length > 2) {

            varName =

                    (CompoundVariable) values[2];

        } else {

            varName = null;

        }

    }

    @Override

    public String getReferenceKey() {

        return KEY;

    }
}
