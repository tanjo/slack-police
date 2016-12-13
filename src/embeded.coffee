`
/**
 * @type {number}
 */
var DATATYPE_NEW_CHANNEL = 1;

/**
 * @type {number}
 */
var DATATYPE_PURPOSE = 2;

/**
 * @type {number}
 */
var DATATYPE_TOPIC = 3;

/**
 * @type {number}
 */
var DATATYPE_ARCHIVE = 4;

/**
 * Get Slack Police Instance.
 * @param {Sheet} sheet - sheet for data storage
 * @param {string} token - Slack API token
 * @return {SlackPolice} return Slack Police Instance
 */
function getInstance(sheet, token) {
  return new SlackPolice(sheet, token);
}

/**
 * 利用するデータタイプを追加
 * @param {number} column - Data storage column
 * @param {string} message - message
 * @param {number} dataType - DataType
 * @return {SlackPolice} return Slack Police Instance
 */
function addDataType(column, message, dataType) {

}

/**
 * Debug mode <br>
 * Slack に投稿されずに Logger.log で結果が出力されます
 * @param {boolean} debug - use debug mode
 * @return {SlackPolice} return Slack Police Instance
 */
function setDebug(debug) {

}

/**
 * As User
 * if you use Slack Bot, this flag must be true.
 * @param {boolean} asUser
 * @return {SlackPolice} return Slack Police Instance
 */
 function setAsUser(asUser) {

 }

/**
 * Setting custom username <br>
 * default username is "Slack警察"
 * @param {string} username - custom username
 * @return {SlackPolice} return Slack Police Instance
 */
function setUsername(username) {

}

/**
 * Setting custom icon_emoji <br>
 * default icon_emoji is ":cop:"
 * @param {string} icon_emoji - custom icon_emoji
 * @return {SlackPolice} return Slack Police Instance
 */
function setIconEmoji(iconEmoji) {

}

/**
 * Setting slack channel name <br>
 * @param {string} channel - it needs "#".
 * @return {SlackPolice} return Slack Police Instance
 */
function setChannel(channel) {

}

/**
 * find data from sheet data array.
 */
Array.prototype.findIndex = function(search) {
  if (search == "") {
    return false;
  }
  for (var i = 0; i < this.length; i++) {
    if (this[i] == search) {
      return i;
    }
  }
  return -1;
}

Array.prototype.findChannelName = function(search) {
  if (search == "") {
    return false;
  }
  for (var i = 0; i < this.length; i++) {
    if (this[i].name == search) {
      return i;
    }
  }
  return -1;
}
`
