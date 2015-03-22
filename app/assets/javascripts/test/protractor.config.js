exports.config = {
  seleniumAddress: 'http://localhost:4444/wd/hub',
  
  capabilities: {
    'browserName': 'chrome'
  },

  specs: ['loginE2E.test.js'],

  // Options to be passed to Jasmine-node.
  jasmineNodeOpts: {
    onComplete: null,
    isVerbose: false,
    showColors: true,
    includeStackTrace: true
  }
};
