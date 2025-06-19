package com.toad.ApiService.util;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class APISpringbootUtil {
    // 二进制读取
    public static byte[] readAsBytes(HttpServletRequest request){

        if (!"POST".equals(request.getMethod())){
            return null;
        }

        int len = request.getContentLength();
        if (len < 1){
            return null;
        }

        byte[] buffer = new byte[len];
        ServletInputStream in = null;

        try
        {
            in = request.getInputStream();
            in.read(buffer, 0, len);
            in.close();
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            if (null != in)
            {
                try
                {
                    in.close();
                }
                catch (IOException e)
                {
                    e.printStackTrace();
                }
            }
        }
        return buffer;
    }
}
