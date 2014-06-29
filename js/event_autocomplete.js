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

function changeValueToGoogleCode(element) {
    element.value = getValueFromKey(element);
}

function getValueFromKey(element) {
    var key = element.value;
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
