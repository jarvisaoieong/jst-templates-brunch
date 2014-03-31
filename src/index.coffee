module.exports = class JstTemplatesCompiler

  brunchPlugin: yes
  type: 'template'
  extension: 'js'

  constructor: (config) ->
    @namespace = config.plugins?.jstTemplates?.namespace or 'JST'
    @basePath = config.plugins?.jstTemplates?.basePath or 'app'
    @keepExt = config.plugins?.jstTemplates?.keepExt
    @pattern = config.plugins?.jstTemplates?.pattern or /\.(html|jade|eco|hbs|handlebars)$/

  compile: (data, path, callback) ->
    if @basePath
      regex = new RegExp "^#{@basePath}\/"
      path = path.replace regex, ''

    if not @keepExt
      path = path.replace /\.\w+$/, ''

    callback null, """
      (function() {
        window['#{@namespace}'] = window['#{@namespace}'] || function(name) {
          return window['#{@namespace}'][name];
        };

        // Force CommonJS to capture from preprocessors
        var define, module = { exports: true };

        // Include the data from preprocessor
        #{data};

        window['#{@namespace}']['#{path}'] = module.exports;

      })();
    """