var PointGaming = PointGaming || {};

PointGaming.DesktopController = function(){
  this.client_checker = new PointGaming.ClientChecker({});

  this.element_decorator = {
    clientInstalled: function(element) {
      this.removeClasses(element);
      element.addClass('client-installed');
    },
    clientNotInstalled: function(element) {
      this.removeClasses(element);
      element.addClass('client-not-installed');
    },
    clientOutOfDate: function(element) {
      this.removeClasses(element);
      element.addClass('client-out-of-date');
    },
    removeClasses: function(element) {
      element.removeClass('check-for-client client-installed client-not-installed client-out-of-date');
    }
  };

  if ($('a.requires-desktop-client').length > 0) {
    this.checkForClient();
  }

  this.registerHandlers();
};

PointGaming.DesktopController.prototype.decorateElement = function(element) {
  element = element || $('.requires-desktop-client');
  if (this.client_checker.clientInstalled) {
    if (this.client_checker.clientOutOfDate) {
      this.element_decorator.clientOutOfDate(element);
    } else {
      this.element_decorator.clientInstalled(element);
    }
  } else {
    this.element_decorator.clientNotInstalled(element);
  }
};

PointGaming.DesktopController.prototype.checkForClient = function(callback, recheck) {
  var self = this;

  this.client_checker.checkClientInstalled(function(err, client_checker){
    self.decorateElement();

    if (typeof(callback) === 'function') {
      callback(err, client_checker);
    }
  }, recheck);
};

PointGaming.DesktopController.prototype.registerHandlers = function() {
  var self = this;

  $(document).on('click', 'a.requires-desktop-client.client-installed[data-action="joinLobby"]', this.joinLobby.bind(this));
  $(document).on('click', 'a.requires-desktop-client.client-not-installed[data-action="joinLobby"]', this.displayClientRequiredModal.bind(this));

  $(document).on('click', 'a.requires-desktop-client.check-for-client', function(e) {
    var action = $(e.target);

    self.checkForClient(function(err, client_checker) {
      self.decorateElement(action);
      action.click();
    });
  });
  $(document).on('click', '#desktop-client-required-modal a[data-action="tryAgain"]', function() {
    var action = $('#desktop-client-required-modal #desktop-client-action-container :first-child');

    $('#desktop-client-required-modal').modal('hide');

    self.checkForClient(function(err, client_checker) {
      action.click();
    }, true);
  });
};

PointGaming.DesktopController.prototype.joinLobby = function(e) {
  var self = this,
      game_id = $(e.target).attr('href').split(':')[2];
  e.preventDefault();

  $('body').modalmanager('loading');

  PointGaming.DesktopConnector.joinLobby(game_id)
    .done(function(data){
      $('body').modalmanager('loading');
    })
    .fail(function(jqXHR, textStatus){
      $('body').modalmanager('loading');

      self.displayClientRequiredModal(e);
    });

  return false;
};

PointGaming.DesktopController.prototype.displayClientRequiredModal = function(e) {
  e.preventDefault();

  var modal = $('#desktop-client-required-modal'),
      actionContainer = $('#desktop-client-action-container', modal);

  actionContainer.html('');
  actionContainer.append($(e.target).clone());

  modal.modal({});
  return false;
};
