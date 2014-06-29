<html>
    <head>
        <!-- Jquery Javascript -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    </head>
    <body>
        <div class="example" id="the-basics">
            <h2 class="example-name">The Basics</h2>
            <p class="example-description">
                When initializing a typeahead using the <a href="https://github.com/twitter/typeahead.js/blob/master/doc/jquery_typeahead.md">typeahead.js jQuery plugin</a>,
                you pass the plugin method one or more <a href="https://github.com/twitter/typeahead.js/blob/master/doc/jquery_typeahead.md#datasets">datasets</a>.
                The source of a dataset is responsible for computing a set of
                suggestions for a given query.
            </p>
            <div class="demo">
                <input id="auto" class="typeahead" type="text" placeholder="States of USA">
                <button class="typehead"  onclick="getValueFromKey()">Click</button>
            </div>
        </div>
    </body>

    <script src="../js/typeahead.bundle.js"></script>
    <script>
        var associative_array = {'Atlanta': 'atlanta_city', 'Amusement Park': 'amusement_park'};

        var states = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California',
            'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii',
            'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
            'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
            'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire',
            'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota',
            'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island',
            'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont',
            'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'
        ];

        function getValueFromKey() {
            var key = document.getElementById("auto").value;
            var value = null;
            for ( var i in associative_array )
            {
                if (i === key)
                    value = associative_array[i];
            }
            return value;
        }

        var substringMatcher = function (strs) {
            return function findMatches(q, cb) {
                var matches, substrRegex;
                matches = [];
                substrRegex = new RegExp(q, 'i');
                $.each(strs, function (i, str) {
                    if (substrRegex.test(str)) {
                        matches.push({ value: str });
                    }
                });
                cb(matches);
            };
        };

        function keys(obj) {
            var keys = [];
            for (var key in obj) {
                if(obj.hasOwnProperty(key)) {
                    keys.push(key);
                }
            }
            return keys;
        }

        $('.typeahead').typeahead({
            hint: true,
            highlight: true,
            minLength: 1
        },
        {
            name: 'states',
            displayKey: 'value',
            source: substringMatcher(keys(associative_array))
        });

    </script>
</html>