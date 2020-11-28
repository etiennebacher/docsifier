## How to deploy

`docsify.js` documentation can be deployed with several tools, which are detailed [here](https://docsify.js.org/#/deploy). I can't detail the way to deploy the documentation with all these tools here, as I only tested one of them. Therefore, I only describe my experience below. Refer to the link above if you want to deploy with GitHub pages for example (which should be quite similar than for a blog if you have one).



## Personal walkthrough

This is the situation I am in:

* I have a website made with `{blogdown}`, deployed through Netlify;

* I have a custom domain name, such as `mywebsite.com`;

* I would like to have the package documentation as a subdomain, such as `mypackage.mywebsite.com`.

If you are in the same situation, you can follow the steps below. Otherwise, you should refer to the `docsify.js`'s documentation linked above.

**Step 1:** Push your package with the documentation to GitHub

**Step 2:** Log into Netlify with your GitHub account

**Step 3:** Create a "New site from Git" and choose GitHub as Git provider.

**Step 4:** Choose the repo containing your package.

**Step 5:** In "Basic build settings", write "docs" (the name of the folder where the documentation is stored) in "Publish directory". Click on "Deploy site".

Your page with the documentation is created, but the domain is a random name so we need to change it.

**Step 6:** Click on "Domain settings". In "Custom domains", click on "Add custom domain". 

**Step 7:** Add a custom domaine name. For example, if you own `mywebsite.com`, you can name the custom domain as `mypackage.mywebsite.com`.

**Step 8:** Confirm that you are the owner of `mywebsite.com`.

**Step 9:** Force HTTPS (automatically proposed by Netlify).

Done! You can now check at `mypackage.mywebsite.com` that the documentation is well loaded. This will update every time you push changes in `/docs` on GitHub.



