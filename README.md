##CoffeeForEveryone
The coffeeShop case study
In this project we created two websites both located in New York and London. One called contosocoffeelondon and the other contosocoffeenewyork.

We chose the Difficulty Level 3: Host the Docker Container solution via Azure Container Registries and pull into an Azure ACI solution.

##Company Overview
Contoso Coffee is a small coffee house that is opening soon in London and New York, they are looking for a cloud hosted solution for their website and data storage, costs must be kept to a minimum.

Our solution to meet the requirements
Here is the steps to create the project.

Build a docker image

Run a docker container.

Create a container registry in Azure.

Create two Azure container instances (ACI) that runs the website in both London and New York. It has to be in different regions to be redundant.

Then loadbalance those two with geo-redundancy. We chose Traffic Manager.

Create a storage account with blob storage and create a lifecycle management rule that says move to Archive tier after 30 days. Here we created a SAS key that can last for x amount of time.

Create a static web app that displays pictures from the blob container.

User accounts
Contoso coffee requires 3 Administrators for the day to day control of the solution.

Bob

Bob will require full admin access as it will be his responsibility to manage and track billing for the Contoso Coffee website and is the owner of Contoso Coffee. He will therefore get global admin and owner role.

Dave

Dave requires admin access to the resources hosted on Azure for the Contoso Coffee website but not overall administration of the Contoso Coffee subscription. He will get contributor role scoped to the resource group.

Mark

Mark will require read-only access to the Contoso Coffee resources. He will therefore get read-only access scoped to the resource group.

  ![image](https://user-images.githubusercontent.com/70135704/226916537-bbcbc859-9002-4b0d-9ccc-71d21d10f882.png)



Load Balancing and Geo-redundent access
Contoso Coffee will operate in London and New York, because of this a solution will need to be configured that allows the US users to access a more local server than London and vice versa. Load balancing can be achieved through DNS redirection or a geo-load balanced solution.

![image](https://user-images.githubusercontent.com/70135704/226916682-7163bcc5-bb8e-4005-be14-b553f04c0b9b.png)
