// Karma configuration
// Generated on Mon May 19 2014 22:24:59 GMT+0200 (CEST)

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '',


    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['ng-scenario'],


    // list of files / patterns to load in the browser
    files: [
	'loginE2E.test.js'      
    ],


    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    proxies: {
    	'/': 'http://localhost:8080/'
    },

    urlRoot: '/_karma/',

    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,

	plugins: [
		'karma-ng-scenario'
		'karma-chrome-launcher'
	],

    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['Chrome'],

    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: false
  });
};
