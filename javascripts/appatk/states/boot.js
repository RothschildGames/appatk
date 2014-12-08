(function() {
  AppAtk.Boot = (function() {
    function Boot() {}

    Boot.prototype.init = function() {
      this.input.maxPointers = 1;
      return this.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
    };

    Boot.prototype.preload = function() {
      return this.load.image('loading-background', 'images/loading-background.png');
    };

    Boot.prototype.create = function() {
      return this.state.start('loader');
    };

    return Boot;

  })();

}).call(this);
