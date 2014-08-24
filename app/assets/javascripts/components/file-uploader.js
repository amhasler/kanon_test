/* File uploader component. Needs:
 * - apiUrl: URL of the file upload REST endpoint.
 * - authParams: authentication parameters for the user
 */
PageOne.FileUploaderComponent = Ember.Component.extend({
  classNames: ['file-uploader'],
  didInsertElement: function() {
    var self = this;

    /* File uploader */
    this.$("input[type='file']").fileupload({
      dataType: 'json',
      url: this.get('apiUrl'),
      formData: {
        "auth[login]": this.get('authParams.login'),
        "auth[token]": this.get('authParams.token')
      },
      disableImagePreview: true,
      submit: function() {
        Ember.run(function() {
          self.sendAction('initUpload');
        });
      },
      done: function(e, data) {
        Ember.run(function() {
          self.sendAction('success', data.jqXHR.responseJSON);
        });
      },
      fail: function(e, data) {
        Ember.run(function() {
          self.sendAction('failure', data.jqXHR.responseJSON);
        });
      }
    });
  },
  actions: {
    uploadFile: function() {
      this.$("input[type='file']").click();
    },
  }
});
