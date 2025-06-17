import hashlib


body= {"vin":"JTJCBCCZ1M2000101","realname_status":"1","produce_type":"1","msg":"msg"}

def md5Str(str):
    md5 = hashlib.md5()
    md5.update(str.encode('utf-8'))
    return md5.hexdigest()

str=""
for k in sorted(body):
    str=str+k+"="+body[k]

print("Body 升序排列：" + str);
md5 = md5Str(str);
print("md5：" + md5);
md5a = md5 + "a";
print("md5拼接私钥:" + md5a);
sign = md5Str(md5a);
print("Sign：" + sign);
