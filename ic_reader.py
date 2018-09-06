#!/user/bin/env python
# -*- coding: utf-8 -*-
#
# 读卡器动态库调用测试
# doc文档记录使用BY_Interface.dll, dcrf32.dll, DesAlgo.dll三个动态库，
# 但本例中只需要用BY_Interface.dll一个，可能另两个调用封装在这个里，
# 未再进行测试。
#
# 动态库加载方式一定根据类型选择，否则会报参数错误。
# By: LiuBin
# On: 2018-09-06

import os
from ctypes import *

errors = {
'-13': '非本系统卡',
'-14': 'PIN值错误',
'-15': 'BCD格式数据中出现非数字字符',
'-16': '关闭端口失败',
'-17': '打开端口失败',
'-18': '寻卡请求失败',
'-19': 'IC卡防冲突失败',
'-20': '选卡失败',
'-21': '读卡序列号失败',
'-30': 'MF11RF08PUTH卡密钥装载失败',
'-41': '选择应用失败或卡片未发行',
'-31': '密钥认证失败',
'-32': '读卡信息操作失败',
'-34': '写卡信息操作失败',
'-55': '数据长度错误',
'-52': '未插PSAM,或PSAM卡上电失败!',
'-80': '母卡使用限制'
}


os.chdir('G:/it/python/IC_reader/')
# interface = cdll.LoadLibrary('BY_Interface.dll')
interface = windll.LoadLibrary('BY_Interface.dll')
# interface.iDOpenPort.argtypes = [c_int]
# interface.iDOpenPort.restype = c_int
port = interface.iDOpenPort(100)
print(port)
beep = interface.IDBeep(port, 10)
print(beep)

card_type = c_int(1)
card_sn = c_char_p(b'22321')
card = interface.CheckCardType(port, byref(card_type), card_sn)
print('card %s' % card)

# base_info = c_char_p(b"base_info")
base_info = create_string_buffer(b'\000' * 65)
info = interface.ReadBaseInfo(port, 65, byref(base_info))
print(base_info.value.decode('gbk'))
print(len(base_info.value))
print(base_info.value[0:12])
print(base_info.value[12:44].decode('gbk'))
print(base_info.value[44:45])

patient_id = create_string_buffer(b'\000' * 15)
patient_name = create_string_buffer(b'\000' * 35)
gender = create_string_buffer(b'\000' * 2)
birthday = create_string_buffer(b'\000' * 15)
charge_type = create_string_buffer(b'\000' * 15)
response_type = create_string_buffer(b'\000' * 15)
BMI_NO = create_string_buffer(b'\000' * 15)
rs = interface.ReadBaseInfoVar(port,
        byref(patient_id),
        byref(patient_name),
        byref(gender),
        byref(birthday),
        byref(charge_type),
        byref(response_type),
        byref(BMI_NO))
if rs:
    interface.IDBeep(port, 1000)
    print('error No: %s' % rs)
    print('error message: %s' % errors[str(rs)])
else:
    print(patient_id.value)
    # bytes 型转gbk
    print(patient_name.value.decode('gbk'))
    print(gender.value)
    print(birthday.value)
    print(charge_type.value)
    print(response_type.value)
    print(BMI_NO.value)

cport = interface.iDClosePort(port)
print(cport)


