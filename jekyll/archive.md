---
layout: static
title: Archive
---
<ul class="posts">
{% for post in site.posts %}
		
	{% unless post.next %}
		<h2>{{ post.date | date: '%Y' }}</h2>
	{% else %}
		{% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
		
		{% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}
		
		{% if year != nyear %}
			<h2>{{ post.date | date: '%Y' }}</h2>
		{% endif %}
		
	{% endunless %}
	
	<li>
		<a href="{{ post.url }}">{{ post.title }}</a>
		<abbr>{{ post.date | date_to_string }}</abbr>
		<div class="categories">Filed under 
			{% for item in post.categories %}
				{% if forloop.last %}
					and 
				{% endif %}
				
				<a href="/{{ site.category_dir }}/{{ item }}.html">{{ item }}</a>{% unless forloop.last or forloop.rindex == 2%},{% endunless %}
			{% endfor %}
		</div>
	</li>	
	
{% endfor %}
</ul>