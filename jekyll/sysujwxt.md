---
layout: static
title: SYSUJWXT API
---

<div class="notice">
本 API 为第一版，提供了基本的认证后查询功能。API 服务器的地址是 http://api.sysujwxt.com/v1/，所有的数据通过 JSON 交互。
</div>


常见参数
-------

因为提供的都是认证后的信息获取，所以只能接受 POST 请求。用到的参数如下：

{% highlight bash %}
usernames     # 登陆用学号
password      # 密码
token         # 登陆成功后获得的 token
sno           # 学号
year          # 学年度，格式为 2011-2012
term          # 学期
course_type   # 课程类型
grade         # 年级
tno           # 教学号
{% endhighlight %}

错误处理
-------

1 发送的 JSON 如果缺少必要的参数会导致 400 Bad Request 错误。

{% highlight http %}
HTTP/1.0 400 BAD REQUEST
Content-Type: application/json

{
  "message": "Bad Request"
}
{% endhighlight %}


2 认证失败会导致 401 Authentication Failed 错误。

{% highlight http %}
HTTP/1.0 401 UNAUTHORIZED
Content-Type: application/json

{
  "message": "Authentication Failed"
}
{% endhighlight %}

3 Token 超时会导致 403 Session Expired 错误。

{% highlight http %}
HTTP/1.0 403 FORBIDDEN
Content-Type: application/json

{
  "message": "Session Expired"
}
{% endhighlight %}

4 API 服务查询超时会导致 408 Request Timeout 错误，此时基本是学校的服务器已不可用。

{% highlight http %}
HTTP/1.0 408 Request Timeout
Content-Type: application/json

{
  "message": "Request Timeout"
}
{% endhighlight %}

认证
----

验证成功获取了 Token 才能进行下一步的查询操作，Token 的生命为 30 分钟 - 2 小时不等。

### URL

{% highlight bash %}
POST /sign_in
{% endhighlight %}

### 参数

{% highlight bash %}
username = 11111111
password = 12345678
{% endhighlight %}

### 结果

{% highlight bash %}
HTTP/1.0 200 OK
Content-Type: application/json

{
  "token": "AA65ACC1AF06359F4E36098AAE520538"
}
{% endhighlight %}

查询功能
-------

所有的查询功能使用时都必须同时上传 token 参数。

### 个人信息

### URL

{% highlight bash %}
POST /info
{% endhighlight %}

### 参数

{% highlight bash %}
token = AA65ACC1AF06359F4E36098AAE520538
sno   = 11111111
{% endhighlight %}

### 结果

{% highlight http %}
HTTP/1.0 200 OK
Content-Type: application/json

{
    "xh": "学号",
    "xm": "姓名",
    "cym": "曾用名",
    "zyh": "专业号",
    "rxny": "入学年月",
    "nj": "年级",
    "hkszd": "省份",
    "tc": "没啥特长呢",
    "lxdh": "联系电话",
    "dzxx": "邮箱",
    "byxx": "毕业学校",
    "xymc": "学院",
    "zyfxmc": "专业",
    "yzbm": "邮政编码",
}
{% endhighlight %}

### 分数

### URL

{% highlight bash %}
POST /score
{% endhighlight %}

### 参数

{% highlight bash %}
token = AA65ACC1AF06359F4E36098AAE520538
year  = 2011-2012
term  = 1
{% endhighlight %}

### 结果

{% highlight http %}
HTTP/1.0 200 OK
Content-Type: application/json

[
    {
        "jxbpm": "教学班排名",
        "jd": "绩点",
        "jxbh": "教学编号",
        "jsxm": "教师姓名",
        "xnd": "学年度",
        "xq": "学期",
        "xh": "学号",
        "kcywmc": "课程英文名称",
        "kch": "课程号",
        "kcmc": "课程名称",
        "kclb": "课程类别",
        "xf": "学分",
        "xs": "学时",
        "zpcj": "总评成绩",
        "zzcj": "最终成绩",
        "sftg": "是否通过",
        "cjzt": "成绩状态",
        "resource_id": "课程资源号",
    }
]
{% endhighlight %}

### 课表

### URL

{% highlight bash %}
POST /timetable
{% endhighlight %}

### 参数

{% highlight bash %}
token = AA65ACC1AF06359F4E36098AAE520538
year  = 2011-2012
term  = 1
{% endhighlight %}

### 结果

{% highlight http %}
HTTP/1.0 200 OK
Content-Type: application/json

[
    {
        "dsz": "01",
        "weekpos": "1",
        "kcmc": "江南Style过程与方法导论",
        "dd": "实验中心B403",
        "zfw": "1-17",
        "jc": "7-9节"
    },
    {
        "dsz": "01",
        "weekpos": "2",
        "kcmc": "萝莉塔养成应用方法",
        "dd": "东C205",
        "zfw": "1-17",
        "jc": "3-5节"
    }
]
{% endhighlight %}

### 选课结果

### URL

{% highlight bash %}
POST /course_result
{% endhighlight %}

### 参数

{% highlight bash %}
token = AA65ACC1AF06359F4E36098AAE520538
year  = 2011-2012
term  = 1
{% endhighlight %}

### 结果

{% highlight http %}
HTTP/1.0 200 OK
Content-Type: application/json

[
    {
        "xnd": "学年度",
        "xq": "学期",
        "resource_id": "课程资源号",
        "pylbm": "培养类别",
        "kclbm": "课程类别",
        "kch": "课程号",
        "xf": "学分",
        "xh": "学号",
        "jxbh": "教学编号",
        "kcmc": "课程名称",
        "khfs": "考核方式",
        "xkjd": "选课阶段",
        "xkcgbz": "选课状态",
    }
]
{% endhighlight %}

### 已获得学分

URL
{% highlight bash %}
POST /earned_credit
{% endhighlight %}

参数
{% highlight bash %}
token = AA65ACC1AF06359F4E36098AAE520538
sno   = 11111111
year  = 2011-2012
term  = 1
{% endhighlight %}

结果

{% highlight http %}
HTTP/1.0 200 OK
Content-Type: application/json

[
    {
        "oneColumn": "公必学分",
        "twoColumn": "44.0"
    },
    {
        "oneColumn": "专必学分",
        "twoColumn": "88.0"
    },
    {
        "oneColumn": "专选学分",
        "twoColumn": "22.0"
    },
    {
        "oneColumn": "公选学分",
        "twoColumn": "11.0"
    }
]
{% endhighlight %}

### GPA

### URL

{% highlight bash %}
POST /gpa
{% endhighlight %}

### 参数

{% highlight bash %}
token = AA65ACC1AF06359F4E36098AAE520538
sno   = 11111111
year  = 2011-2012
term  = 1
{% endhighlight %}

### 结果

{% highlight http %}
HTTP/1.0 200 OK
Content-Type: application/json

[
    {
        "oneColumn": "公必平均绩点",
        "twoColumn": "2.2"
    },
    {
        "oneColumn": "专必平均绩点",
        "twoColumn": "2.2"
    },
    {
        "oneColumn": "专选平均绩点",
        "twoColumn": "2.2"
    },
    {
        "oneColumn": "公选平均绩点",
        "twoColumn": "2.2"
    }
]
{% endhighlight %}


意见与建议
--------

您在使用时遇到了什么问题，或者有什么建议，欢迎与我们联系。

感谢
----

感谢网络中心为我们提供了服务器，在第一版 App 推出后我们会进一步合作添加新的 API 支持。
