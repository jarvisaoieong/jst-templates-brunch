Wrap templates to JST function for Brunch
=========================================

Installation
------------

```
npm install --save jst-templates-brunch
```

Usage
-----

For instance, use with `jaded-brunch`

1. Install the plugin

```
npm install --save jaded-brunch jst-templates-brunch
```

make sure the `jaded-brunch` is prior than `jst-templates-brunch` in package.json

1. Set `joinTo` attribute for `templates` in `config.coffee`, e.g.

```coffee
templates:
  joinTo:
    'templates.js': /^app/
```

2. In your markup, include `templates.js`:

```html
<script type="text/javascript" src="/templates.js"></script>
```

3. Use the template function in your app

There is a jade file located in 'app/apps/header/templates/header.jade'.

You can reference the template function in

```js
templateFn = JST('apps/header/templates/header')
// OR
templateFn = JST['apps/header/templates/header']
```

Options
-------

### namespace

Specify the namespace of the template function

Default: `JST`

```coffee
plugins:
  jsttemplates:
    namespace: 'MyTemplateFn'
```

### basePath

Specify the base path to omit in the template function name

Default: `app`

### keepExt

Keep the template file extension in the template function name or not

Default: `false`