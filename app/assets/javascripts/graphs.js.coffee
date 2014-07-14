$(document).on "ready page:load", ->
  $(".graph").each ->
    m = [ 80, 80, 80, 80 ] # margin
    w = 1000 - m[1] - m[3] # width
    h = 400 - m[0] - m[2] # height

    json_data = $(this).data('data')
    data = json_data["trackers"]
    id = "#" + $(this).attr('id')

    x = d3.scale.ordinal().domain(json_data["time_periods"]).rangePoints([0, w]);
    y = d3.scale.linear().domain([0, $(this).data('max')]).range([h, 0])

    line = d3.svg.line().x((d, i) ->
      x i
    ).y((d) ->
      y d
    )


    graph = d3.select(id).append("svg:svg").attr("width", w + m[1] + m[3]).attr("height", h + m[0] + m[2]).append("svg:g").attr("transform", "translate(" + m[3] + "," + m[0] + ")")
    xAxis = d3.svg.axis().scale(x).tickSize(-h).tickSubdivide(true)
    graph.append("svg:g").attr("class", "x axis").attr("transform", "translate(0," + h + ")").call xAxis
    yAxisLeft = d3.svg.axis().scale(y).ticks(4).orient("left")
    graph.append("svg:g").attr("class", "y axis").attr("transform", "translate(-25,0)").call yAxisLeft
    graph.append("svg:path").attr "d", line(data)

    #Axis Labels
    graph.append("text").attr("text-anchor", "middle").attr("transform", "translate(-60," + (h/2) + ")rotate(-90)").text("Hours")
    graph.append("text")
            .attr("text-anchor", "middle")
            .attr("transform", "translate("+ (w/2) + "," + (h+40) + ")")
            .text($(this).data('x-axis'));
