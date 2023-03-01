const { google } = require('googleapis');

const privatekey = require('./arhitecturi-bot.json');
const scopes = ['https://www.googleapis.com/auth/spreadsheets'];

var sheetDict = {
  "C-112A": 0,
  "C-112B": 306790469,
  "C-112C": 164198878,
  "C-112D": 951319946,
  "C-112E": 577175168,
};

const jwtClient = new google.auth.JWT(
  privatekey.client_email,
  null,
  privatekey.private_key,
  scopes
);

jwtClient.authorize(function(err, tokens) {
    if (err) {
      console.error(err);
      return;
    }
    const sheets = google.sheets({ version: 'v4', auth: jwtClient });

    const spreadsheetId = process.argv[2]
    const sheetId = process.argv[3]
    const cellNumber = process.argv[4]
    const newValue = process.argv[5]
    const passedColor = {
        red: 0,
        green: 1,
        blue: 0,
    };
    const failedColor = {
        red: 1,
        green: 0,
        blue: 0,
    };

    sheets.spreadsheets.values.get({
      spreadsheetId,
      range: `${sheetDict[sheetId]}!C1:C`
    }, (err, res) => {
      if (err) {
        console.error(err);
        return;
      }
    });

    const values = res.data.values;
    console.log(values)
});