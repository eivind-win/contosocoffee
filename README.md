
# CoffeeForEveryone

## The coffeeShop case study

In this project we created two websites both located in New York and London. One called contosocoffeelondon and the other contosocoffeenewyork. 

We chose the Difficulty Level 3: Host the Docker Container solution via Azure Container Registries and pull into an Azure ACI solution.

## Company Overview

Contoso Coffee is a small coffee house that is opening soon in London and New York, they are looking for a cloud hosted solution for their website and data storage, costs must be kept to a minimum.

## Our solution to meet the requirements

Here is the steps to create the project. 

1. Build a docker image 

2. Run a docker container. 

3. Create a container registry in Azure. 

4. Create two Azure container instances (ACI) that runs the website in both London and New York. It has to be in different regions to be redundant. 

5. Then loadbalance those two with geo-redundancy. We chose Traffic Manager. 

6. Create a storage account with blob storage and create a lifecycle management rule that says move to Archive tier after 30 days. Here we created a SAS key that can last for x amount of time. 

7. Create a static web app that displays pictures from the blob container. 

## User accounts

Contoso coffee requires 3 Administrators for the day to day control of the solution.

*Bob*

Bob will require full admin access as it will be his responsibility to manage and track billing for the Contoso Coffee website and is the owner of Contoso Coffee. He will therefore get global admin and owner role. 

*Dave*

Dave requires admin access to the resources hosted on Azure for the Contoso Coffee website but not overall administration of the Contoso Coffee subscription. He will get contributor role scoped to the resource group. 

*Mark*

Mark will require read-only access to the Contoso Coffee resources. He will therefore get read-only access scoped to the resource group. 

  

<img title="" src="contosocoffee/tree/main/case-study/assets/c89edcde4a2933f30543e3de119b3798a3e62829.png" alt="Contoso coffee_users (1).png" data-align="inline">

## Load Balancing and Geo-redundent access

Contoso Coffee will operate in London and New York, because of this a solution will need to be configured that allows the US users to access a more local server than London and vice versa. Load balancing can be achieved through DNS redirection or a geo-load balanced solution.

![ContosoCoffee_Website hosting (3).png](assets/42bd992c105c28ef62999103e03df026410634d4.png)
