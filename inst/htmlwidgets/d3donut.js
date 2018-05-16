HTMLWidgets.widget({

  name: 'd3donut',

  type: 'output',

  factory: function(el, width, height) {
    var elementId = el.id;

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {
// TODO: code to render the widget, e.g.
// el.innerText = x.message;
var dataset = HTMLWidgets.dataframeToD3(x.message);

var width = 600;
var height = 650;
var radius = Math.min(width, height) / 2;
var donutWidth = 150;

// Set up a vector with the colours to use
// var color = d3.scaleOrdinal(d3.schemeCategory20b);
var sectorcolors = ["#fdbe85", "#bdd7e7", "#bae4b3"];
var sectorcolorshighlighted = ["#a63603", "#08519c", "#006d2c"];
var sectors      = ["tm_da", "trial_code", "trial_biostatistician"];


// Set up the svg object centered on the middle of the object
var svg = d3.select(el)
        .append('svg')
        .attr('width', width)
        .attr('height', height)
        .append('g')
        .attr('transform', 'translate(' + (width/2) + ',' + (height / 2) + ')');

// Set up an arc object with predefined inner & outer radius
var arc = d3.arc()
        .innerRadius(radius - donutWidth)
        .outerRadius(radius);

// Set up an unsorted pie object
var pie = d3.pie()
        .value(function (d) {return d.weight;})
        .sort(null);

// Computes the angle of an arc, converting from radians to degrees.
function angle(d) {
        var a = (d.startAngle + d.endAngle) * 90 / Math.PI - 90;
        return a > 90 ? a - 180 : a;
}

        // Convert count variable from character to numeric
        dataset.forEach (function (d) {
                    d.weight = +d.weight;
        });

        // Draw the segments of the pie using the pie and arc objects
        var path = svg.selectAll()                                                               // Select all tags in the object called 'svg'
                    .data(pie(dataset))                                                                  // Attach the data
                    .enter()
                    .append('path')
                    .attr('id', function(d) {return d.data.id})
                    .attr('class', function(d) {return d.data.sector + " " + d.data.links})
                    .attr('d', arc)
                    .attr('stroke', 'grey')
                    .attr('fill', function(d) {
                                return sectorcolors[sectors.indexOf(d.data.sector)];
                    })
.on('mouseenter', function(d) {
  
  


 var segmentselected = false;

d3.selectAll("path").each (function (d) {
    if (d3.select(this).attr("class").indexOf("clicked") != -1) {
        segmentselected = true;
    }
})

if (segmentselected == false) {
  
  // Note that element ID is defined at the top of the HTMLwidget //
   Shiny.onInputChange( elementId + "_selected", d.data.id);
   console.log(d.data);

    // Change the background fill colour
    d3.select(this).attr('fill', 'purple');
    currID = d3.select(this).attr("id");
    for (i = 0; i < sectors.length; i++) {
        svg.selectAll("." + sectors[i]).filter("." + currID)
            .attr('fill', sectorcolorshighlighted[i]);
        };

    // Add the connecting lines
    startCurve = (radius-donutWidth)*Math.cos((Math.PI/2) - 0.5*(d.startAngle + d.endAngle)) + "," +
                 -(radius-donutWidth)*Math.sin((Math.PI/2) - 0.5*(d.startAngle + d.endAngle));

    var lines = svg.selectAll()
         .data(pie(dataset))
         .enter()
         .append('path')
         .attr('class', 'connectingline')
        .attr('fill', 'none')
         .attr('stroke', 'black')
         .attr('d', function(d) {
            endCurve = (radius-donutWidth)*Math.cos((Math.PI/2) - 0.5*(d.startAngle + d.endAngle)) + "," +
                       -(radius-donutWidth)*Math.sin((Math.PI/2) - 0.5*(d.startAngle + d.endAngle));
            if (d.data.links.indexOf(currID) != -1) {return "M" + startCurve + " Q0,0 " + endCurve;}
          });

    var dots = svg.selectAll()
        .data(pie(dataset))
        .enter()
        .append('circle')
        .attr('class', 'connectingdot')
        .attr('cx', function(d) {if (d.data.id.indexOf(currID) != -1 | d.data.links.indexOf(currID) != -1) {return (radius-donutWidth)*Math.cos((Math.PI/2) - 0.5*(d.startAngle + d.endAngle));}})
        .attr('cy', function(d) {if (d.data.id.indexOf(currID) != -1 | d.data.links.indexOf(currID) != -1) {return  -(radius-donutWidth)*Math.sin((Math.PI/2) - 0.5*(d.startAngle + d.endAngle));}})
        .attr('r', function(d) {if (d.data.id.indexOf(currID) != -1 | d.data.links.indexOf(currID) != -1) {return '3';}});

   
   
    }
    })

    .on('mouseleave', function(d) {
        var segmentselected = false;

        d3.selectAll("path").each (function (d) {
            if (d3.select(this).attr("class").indexOf("clicked") != -1) {
                segmentselected = true;
            }
    })


    if (segmentselected == false) {
        for (i = 0; i < sectors.length; i++) {
            svg.selectAll("." + sectors[i])
               .attr('fill', sectorcolors[i]);
        };
            d3.selectAll("path.connectingline").remove();
            d3.selectAll("circle.connectingdot").remove();
                                                        }
    })

    .on('click', function(d) {

        var selectedsegmentID = "";

        d3.selectAll("path").each(function (d) {
            if (d3.select(this).attr("class").indexOf("clicked") != -1) {
                selectedsegmentID = d3.select(this).attr("id");
             }
        });

        if (selectedsegmentID == "" | selectedsegmentID == d3.select(this).attr("id")) {
            if (d3.select(this).classed('clicked') == true) {
                d3.select(this).classed('clicked', false);
            } else {
                d3.select(this).classed('clicked', true);
            }
        }

    });
    
 
    
    


    var legend = svg.selectAll()
                    .data(pie(dataset))
                    .enter()
                    .append('text')
                    .attr('transform', function(d) {
                    return "translate(" + arc.centroid(d) +
                                      ") rotate(" + angle(d) + ")";
                    })
                    .attr('text-anchor', "middle")
                    .attr('pointer-events', "none")
                    .attr('style', "font-family: Arial; font-size: 12px")
                    .text(function(d) {return d.data.name;});

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});


/*
   Shiny.onInputChange( elementId + "_selected", d.data.id);
   console.log(d.data);
*/
