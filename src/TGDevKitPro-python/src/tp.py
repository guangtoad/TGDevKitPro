import re

def test_regex():
    print("正则表达式测试工具")
    print("-" * 30)
    
    while True:
        # 获取正则表达式
        pattern = input("\n请输入正则表达式 (输入 'q' 退出): ")
        if pattern.lower() == 'q':
            break
            
        try:
            # 编译正则表达式
            regex = re.compile(pattern)
            
            # 获取测试字符串
            while True:
                test_string = input("请输入要测试的字符串 (输入 'n' 测试新的正则): ")
                if test_string.lower() == 'n':
                    break
                
                # 查找所有匹配
                matches = regex.findall(test_string)
                
                # 测试是否完全匹配
                full_match = regex.fullmatch(test_string)
                
                # 显示结果
                print("\n结果:")
                print(f"完全匹配: {'是' if full_match else '否'}")
                print(f"找到的匹配: {matches if matches else '无匹配'}")
                print(f"匹配数量: {len(matches)}")
                
                # 显示所有匹配的位置
                for match in regex.finditer(test_string):
                    print(f"位置 {match.start()}-{match.end()}: {match.group()}")
                
        except re.error as e:
            print(f"正则表达式错误: {str(e)}")
        except Exception as e:
            print(f"发生错误: {str(e)}")

if __name__ == "__main__":
    test_regex()