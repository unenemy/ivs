root = exports ? this
root.fft = (signal, N) ->
    fft = new FFT(N, N)
    fft.forward(signal)
    return fft.spectrum

root.drawchart = (chart, chart_title, chart_container, signal, filtered) ->
  chart = new Highcharts.Chart
    chart:
      renderTo: chart_container
      type: 'line'
    title:
      text: chart_title
    plotOptions:
      line:
        marker:
          enabled: false
    series: [
        name: 'Сигнал'
        data: signal
      ,
        name: 'Фильтрованный сигнал'
        data: filtered
    ]
