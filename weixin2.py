#!/opt/python/bin/python3
#_*_coding:utf-8 _*_

import datetime
import requests,sys,json,time
import urllib3
urllib3.disable_warnings()

today=datetime.date.today()
print(today)

with open("/opt/scripts/job/{0}".format(today),mode='r',encoding='utf-8') as f:
     res=f.read()
print(res)
subject="每日跑批完成情况:"

#user='zcy261'


   # URL = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=a94e8b08-e212-4a54-bb12-8ba687b7d3a4"
def SendMessageURL(User:str,Subject,Messages):
    #webhook换成你机器人的key
    #处理传入的用户id
    user_list = ['<@{}>'.format(user) for user in User.split(";")]
    URL = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=ae9c8197-4e76-4cb2-ab98-5f0b500569bb"
    HEADERS = {"Content-Type": "application/json"}
    Data = {
        "msgtype": "markdown",
        "markdown": { 
                "content": " {} \n {} \n {}".format(Subject, Messages,  ' \n '.join(user_list))
            }
    }
    r = requests.post(url=URL, headers=HEADERS, json=Data, verify=False)
    return r.json()

if __name__ == "__main__":
    SENDTO = str(sys.argv[1])
 #   SENDTO = name
    #SUBJECT = str(sys.argv[2])
    SUBJECT = subject
    #MESSAGE = str(sys.argv[3])
    MESSAGE = res
    SendMessageURL(SENDTO,SUBJECT,MESSAGE)
