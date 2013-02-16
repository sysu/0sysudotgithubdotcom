.PHONY: deploy server

deploy:
	cp -r jekyll/_site/* .

server:
	jekyll  jekyll jekyll/_site --server --auto
