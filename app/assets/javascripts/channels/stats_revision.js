App.stats_revision = App.cable.subscriptions.create('StatsRevisionChannel', {
    connected: function() {
    },
    disconnected: function() {
    },
    received: function(data) {
        if (data.post_id != undefined ) {
            $('.' + data.post_id).text(data.views_stats)
        }
    }
});