# Örnsköldsvik Developer Meetup website

This is a smalll website created at the ODM meetup ["Full stack at its finest - Cutting through the web jungle with Haxe!"](https://www.meetup.com/ovik-dev/events/258157165/) to demonstrate the power of [Haxe](https://haxe.org) in web development.

It compiles to both PHP and javascript, and uses common components to make the site isomorphic.

## Testing it out

For the client, you'll need [Node.js](https://nodejs.org/en/) installed with the [http-server](https://www.npmjs.com/package/http-server) package.

For the server, make sure [PHP 7](http://php.net/) is installed.

For accessing the Meetup API you'll need an api key, which is available from their site [here](https://secure.meetup.com/meetup_api/key/). Create an `.env` file in this directory with the following contents:

```
MEETUP_API_KEY=yourApiKey
```

Then there is a `dev.bat` file that enables quick testing (sorry Linux users, you must decode it), together with VS Code:

The Sass plugin [Easy Sass](https://marketplace.visualstudio.com/items?itemName=spook.easysass) is used to compile the `client.scss` file (make sure you change it once to get the css file), and of course you'll need the [vshaxe](https://github.com/vshaxe/vshaxe/wiki/Installation) extension to run Haxe in VS Code.

After the node and PHP server is up and running, you can compile from VS Code and it will automatically update the project (using the formidable [live.js](http://livejs.com/)).
