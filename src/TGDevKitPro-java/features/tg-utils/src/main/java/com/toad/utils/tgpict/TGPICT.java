//package com.toad.utils.tgpict;
//
//
//import java.io.*;
//import java.util.*;
//
//public class TGPICT {
//
//    public static final String KEY_WORD_LINSPLIT = "\n";
//    public static final String KEY_WORD_KEYSPLIT = ":";
//    public static final String KEY_WORD_VALUESPLIT = ",";
//
//    public class TGPictItems{
//
//        public TGPictItems(){
//        }
//
//        public int getKeyCount() {
//            return this.getKeyList().size();
//        }
//
//        public List<String> keyList;
//        Map<String,List<String>> itemsMap;
//
//        public List<String> getKeyList(){
//            if (null == keyList) {
//                keyList = new ArrayList<String>();
//            }
//            return keyList;
//        }
//
//        public Map<String, List<String>> getItemsMap() {
//            if (null == itemsMap){
//                itemsMap = new HashMap<String, List<String>>();
//            }
//            return itemsMap;
//        }
//
//        public void setItems(String lenStr){
//            this.itemsMap.clear();
//            this.addItems(lenStr);
//        }
//        public void addItems(String lenStr){
//
//            if (TGStringUtils.isNullOrEmpty(lenStr)){
//
//            }
//            else {
//
//                String[] strs = lenStr.split(KEY_WORD_KEYSPLIT);
//
//                if (strs.length > 1){
//
//                    List<String> list = new ArrayList<String>();
//                    String key = strs[0].trim();
//
//                    if (TGStringUtils.isNullOrEmpty(key)){
//                        return;
//                    }
//
//                    String[] values = strs[1].split(TGPICT.KEY_WORD_VALUESPLIT);
//
//                    for (int i = 0 ; i < values.length ; i++){
//                        String value = values[i].trim();
//                        if (!TGStringUtils.isNullOrEmpty(value)){
//                            if (!list.contains(value)){
//                                list.add(value);
//                            }
//                        }
//                    }
//
//                    if (list.size() > 0){
//                        this.getKeyList().add(key);
//                        this.getItemsMap().put(key,list);
//                    }
//                }
//            }
//        }
//
//        public List<StringBuilder> deepCopy(List<StringBuilder> src) throws IOException, ClassNotFoundException{
//            ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
//            ObjectOutputStream out = new ObjectOutputStream(byteOut);
//            out.writeObject(src);
//            ByteArrayInputStream byteIn = new ByteArrayInputStream(byteOut.toByteArray());
//            ObjectInputStream in =new ObjectInputStream(byteIn);
//            List<StringBuilder> dest = (List<StringBuilder>)in.readObject();
//            return dest;
//        }
//
//        public void addSub(int keyIndex, List<StringBuilder> input) throws IOException, ClassNotFoundException{
//            if (keyIndex >=0 && keyIndex < this.keyList.size()){
//                String key = this.keyList.get(keyIndex);
//                List<String> values = this.itemsMap.get(key);
//                int inputSize = input.size();
//                int index = 0;
//                for (int loopNumer = 0 ; loopNumer < inputSize ; loopNumer++){
//                    StringBuilder stringBuilder = input.get(index);
//                    String tmpString = stringBuilder.toString();
//                    for (int i = 0; i < values.size() ; i++){
//                        String value = values.get(i);
//                        switch (i){
//                            case 0: {
//                                stringBuilder.append(String.format(" %s ", TGPICT.KEY_WORD_VALUESPLIT));
//                                stringBuilder.append(value);
//                            }
//                                break;
//                            default: {
//                                StringBuilder newStringBuilder = new StringBuilder(tmpString);
//                                newStringBuilder.append(String.format(" %s ", TGPICT.KEY_WORD_VALUESPLIT));
//                                newStringBuilder.append(value);
//                                input.add(index + i, newStringBuilder);
//                            }
//                                break;
//                        }
//                    }
//                    index += values.size();
//                }
//                addSub(keyIndex + 1, input);
//            }
//        }
//
//        public String getPICTStr() throws TGException{
//            StringBuilder result = new StringBuilder();
//            try {
//                if (this.getKeyCount() == 0){
//                    throw new TGException().setErrorMessage("没有可以");
//                }
//
//                int keyIndex = 0;
//                String key = this.getKeyList().get(keyIndex);
//                List<String> values = this.getItemsMap().get(key);
//                List<StringBuilder> input = new ArrayList<StringBuilder>(values.size());
//                for (int i = 0 ; i < values.size() ; i++) {
//                    StringBuilder stringBuilder = new StringBuilder();
//                    String value = values.get(i);
//                    stringBuilder.append(value);
//                    input.add(stringBuilder);
//                }
//                addSub(keyIndex + 1, input);
//                for (int i = 0 ; i < this.getKeyCount() ; i ++ ){
//                    String tmpKey = this.getKeyList().get(i);
//                    switch (i) {
//                        case 0:
//                            result.append(tmpKey);
//                            break;
//                        default:
//                            result.append(String.format(" %s ",TGPICT.KEY_WORD_VALUESPLIT));
//                            result.append(tmpKey);
//                            break;
//                    }
//                }
//                for (int i = 0 ; i < input.size() ; i++ ){
//                    StringBuilder tmpStringBuffer = input.get(i);
//                    String str = tmpStringBuffer.toString();
//                    result.append(String.format("\n%s", str));
//                }
//            }
//            catch (Exception exc){
//                throw new TGException().setErrorMessage(exc.toString());
//            }
//            return result.toString();
//        }
//    }
//
//    public String createPICTStr(String str) throws TGException,Exception{
//
//        String result = "";
//
//        if (TGStringUtils.isNullOrEmpty(str)) {
//            throw new TGException().setErrorMessage("入力值错误");
//        }
//
//        String[] strs =  str.split(TGPICT.KEY_WORD_LINSPLIT);
//
//        if (strs.length <= 0) {
//            throw new TGException().setErrorMessage("入力值错误");
//        }
//
//        TGPictItems items = new TGPictItems();
//
//        for (int i = 0 ; i < strs.length ; i++) {
//            String linStr = strs[i];
//            items.addItems(linStr);
//        }
//
//        result = items.getPICTStr();
//        return result;
//    }
//
//}
