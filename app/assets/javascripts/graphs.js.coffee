$(document).on "ready page:load", ->
  $(".graph").each ->
    m = [ 80, 80, 80, 80 ]
    w = 1000 - m[1] - m[3] # width
    h = 400 - m[0] - m[2] # height

    json_data = $(this).data('data')
    data = json_data["trackers"]
    id = "#" + $(this).attr('id')

    x = d3.scale.ordinal().domain(json_data["time_periods"]).rangePoints([0, w]);
    y = d3.scale.linear().domain([0, $(this).data('max')]).range([h, 0])

    line = d3.svg.line().x((d, i) ->
      console.log "Plotting X value for data point: " + d + " using index: " + i + " to be at: " + x(i) + " using our xScale."
      x i
    ).y((d) ->
      console.log "Plotting Y value for data point: " + d + " to be at: " + y(d) + " using our yScale."
      y d
    )

    graph = d3.select(id).append("svg:svg").attr("width", w + m[1] + m[3]).attr("height", h + m[0] + m[2]).append("svg:g").attr("transform", "translate(" + m[3] + "," + m[0] + ")")
    xAxis = d3.svg.axis().scale(x).tickSize(-h).tickSubdivide(true)
    graph.append("svg:g").attr("class", "x axis").attr("transform", "translate(0," + h + ")").call xAxis
    yAxisLeft = d3.svg.axis().scale(y).ticks(4).orient("left")
    graph.append("svg:g").attr("class", "y axis").attr("transform", "translate(-25,0)").call yAxisLeft
    graph.append("svg:path").attr "d", line(data)
