#!/opt/python3/bin/python3
#_*_coding:utf-8 _*_

import requests,sys,json,time
import urllib3
urllib3.disable_warnings()

def SendMessageURL(User:str,Subject,Messages):
    #webhook换成你机器人的key
    #处理传入的用户id
    user_list = ['<@{}>'.format(user) for user in User.split(";")]
    URL = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    HEADERS = {"Content-Type": "application/json"}
    Data = {
        "msgtype": "markdown",
        "markdown": { 
                #"content": " <font color=\"warning\">%s</font> \n <font color=\"info\">%s</font> \n <@%s>"% (Subject,Messages,User)
                #"content": " %s \n %s \n <@%s>"% (Subject,Messages,User)
                #"content": " %(subject)s \n %(message)s \n <@%(user)s>" %{"subject":Subject,"message":Messages,"user":User}
                "content": " {} \n {} \n {}".format(Subject, Messages,  ' \n '.join(user_list))
                #"mentioned_list" : [User],
                #"content": \<font color="warning">Subject</font>  \n  Messages,
                #"mentioned_list" :[User],
                #"mentioned_list" :[User,"@all"],
                #"mentioned_mobile_list" : ["13800000000","@all"]
            }
    }
    r = requests.post(url=URL, headers=HEADERS, json=Data, verify=False)
    return r.json()

if __name__ == "__main__":
    SENDTO = str(sys.argv[1])
    SUBJECT = str(sys.argv[2])
    MESSAGE = str(sys.argv[3])
    SendMessageURL(SENDTO,SUBJECT,MESSAGE)
   #Status = str(SendMessageURL(SENDTO,SUBJECT,MESSAGE))
    #print (Status)

