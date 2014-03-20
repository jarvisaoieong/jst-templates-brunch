module.exports = class JstTemplatesCompiler

  brunchPlugin: yes
  type: 'template'
  extension: 'js'
  pattern: /\.(html|jade|eco|hbs|handlebars)$/

  constructor: (config) ->
    @namespace = config.plugins?.jstTemplates?.namespace or 'JST'
    @basePath = config.plugins?.jstTemplates?.basePath or 'app'
    @keepExt = config.plugins?.jstTemplates?.keepExt

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
        window['#{@namespace}']['#{path}'] = #{data}

      })();
    """