import $ from "jquery";
import Highcharts from 'highcharts/highstock';

function openInNewTab(url) {
  var win = window.open(url, '_blank');
  win.focus();
}

function printChart(candles, twitter_statuses) {
  let volumes = candles.map((candle) => [candle[0], candle[2]]);
  console.log(volumes)

  Highcharts.stockChart('chart', {
    rangeSelector: {
      selected: 1
    },

    yAxis: [{
          height: '75%',
          lineWidth: 2
      }, {
          top: '80%',
          height: '20%',
          offset: 0,
          lineWidth: 2
      }],

    series: [{
      type: 'line',
      name: 'USD',
      data: candles,
      id: 'dataseries',
      tooltip: {
        valueDecimals: 2
      }
    }, {
      type: 'column',
      name: 'Volume',
      data: volumes,
      yAxis: 1
    }, {
      type: 'flags',
      data: twitter_statuses,
      onSeries: 'dataseries',
      colorByPoint: true,
      events: {
        click: function (event) {
          let twitterId = event.point.id
          openInNewTab("/twitter_statuses/" + twitterId);
        }
      }
    }]
  });
}


$(document).ready(function () {
  $("#chart").each(function() {
    let currencyId = $(this).data("currencyId")
    console.log("cid", currencyId)

    $.getJSON('/api/candles?currency_id=' + currencyId, function (candles) {
      // let twitter_statuses = [{
      //   x: 1503612540000,
      //   title: 'T',
      //   text: 'Stocks fall on Greece, rate concerns; US dollar dips'
      // }]
      $.getJSON('/api/twitter_statuses?currency_id=' + currencyId, function (twitter_statuses) {
        printChart(candles, twitter_statuses)
      });

    });

  });

})
