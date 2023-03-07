1.

//builds the image named coffee-app (have to be in the coffeeshop)
docker build . -t coffee-app



<img src="../assets/a7f85a61dc5b47bd0399d981908cd423a3e719a2.JPG" title="" alt="git_docker build.JPG" width="539">

2.

//runs container. Create your own name. Opens to port 80. Internal is 49153. 
docker run -d --name contosocontainer -p 49153:80 coffee-app



<img src="../assets/f0c35bff22127ed1bda98b134d9358f4cb82737b.JPG" title="" alt="f0f589829e2e8de6ae0def393827f1ad438a58df.JPG" width="582">

3.

Make a new container registry in Azure. I called it contosocoffeeregistry.

4.

//tags the image to azurecr.io (the registry in Azure)
docker tag coffee-app contosocoffeeregistry.azurecr.io/coffee-app



<img src="../assets/0525fe26f4f09a4d274644c9ff20e711991c865f.JPG" title="" alt="git_tag.JPG" width="628">

5.

//make sure youre logged into Azure (docker login <insert name>.azurecr.io). Pushes image to azurecr.io
docker push contosocoffeeregistry.azurecr.io/coffee-app



<img src="../assets/2e276c0bd90def24a99f108949e0bb28e1bdbdfb.JPG" title="" alt="git_push.JPG" width="595">
