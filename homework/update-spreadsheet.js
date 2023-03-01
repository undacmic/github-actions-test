const { google } = require('googleapis');

const privatekey = require('./arhitecturi-bot.json');
const scopes = ['https://www.googleapis.com/auth/spreadsheets'];

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
    const sheetId = parseInt(process.env.SHEET_ID)
    const cellNumber = parseInt(process.env.CELL_NUMBER)
    const newValue = parseInt(process.env.RESULT)
    console.log(process.env)
    console.log(process.argv)
    console.log(spreadsheetId)
    console.log(sheetId)
    console.log(cellNumber)
    console.log(newValue+1)
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

    sheets.spreadsheets.batchUpdate({
        spreadsheetId,
        resource: {
          requests: [
            {
              updateCells: {
                rows: [
                  {
                    values: [
                      {
                        userEnteredValue: { stringValue: toString(newValue) },
                        userEnteredFormat: { backgroundColor: newValue >= 50 ? passedColor : failedColor },
                      },
                    ],
                  },
                ],
                fields: 'userEnteredValue,userEnteredFormat.backgroundColor',
                range: {
                  sheetId: sheetId,
                  startRowIndex: cellNumber,
                  endRowIndex: cellNumber + 1,
                  startColumnIndex: 2, 
                  endColumnIndex: 3,
                },
              },
            },
          ],
        },
      }, (err, res) => {
        if (err) {
          console.error(err);
          return;
        }
        console.log(res.data);
      });
  });