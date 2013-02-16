---
layout: default
title: Homepage
---

{% assign first_post = site.pages.first %}
<article>
    <h1><a href="{{ first_post.url }}">{{ first_post.title }}</a></h1>
    {{ first_post.content }}
</article>