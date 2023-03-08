return {

keyCommands = 
{
-- Cockpit radios, Intercom
{down = iCommandVoIPRadioPushToTalkEnableDisableVoice, up = iCommandVoIPRadioPushToTalkEnableDisableVoice, value_down = 1.0, value_up = 0.0, name = _('cockpit r.1 VoIP PTT'), category = _('Cockpit radio')},
{down = iCommandVoIPRadioPushToTalkEnableDisableVoice_1, up = iCommandVoIPRadioPushToTalkEnableDisableVoice_1, value_down = 1.0, value_up = 0.0, name = _('cockpit r.2 VoIP PTT'), category = _('Cockpit radio')},
{down = iCommandVoIPRadioPushToTalkEnableDisableVoice_2, up = iCommandVoIPRadioPushToTalkEnableDisableVoice_2, value_down = 1.0, value_up = 0.0, name = _('cockpit r.3 VoIP PTT'), category = _('Cockpit radio')},
{down = iCommandVoIPRadioPushToTalkEnableDisableVoice_3, up = iCommandVoIPRadioPushToTalkEnableDisableVoice_3, value_down = 1.0, value_up = 0.0, name = _('cockpit r.4 VoIP PTT'), category = _('Cockpit radio')},
{down = iCommandVoIPIntercomPushToTalkEnableDisableVoice, up = iCommandVoIPIntercomPushToTalkEnableDisableVoice, value_down = 1.0, value_up = 0.0, name = _('cockpit int.1 VoIP PTT'), category = _('Cockpit Intercom')},
{down = iCommandVoIPIntercomPushToTalkEnableDisableVoice_1, up = iCommandVoIPIntercomPushToTalkEnableDisableVoice_1, value_down = 1.0, value_up = 0.0, name = _('cockpit int.2 VoIP PTT'), category = _('Cockpit Intercom')},

-- RADIO 1
{down = iCommandDynamicRadioPushToTalkEnableVoice, up = iCommandDynamicRadioPushToTalkDisableVoice, value_down = 0.1, value_up = 0.0, name = _('r.1 VoIP PTT'), category = _('Radio 1')},
{down = iCommandDynamicRadioModulationNext, value_down = 0.1, value_up = 0.0, name = _('r.1 Modulation change'), category = _('Radio 1')},
{down = iCommandDynamicRadioFreqChangeSelectorNext, value_down = 0.1, value_up = 0.0, name = _('r.1 Frequency change selector'), category = _('Radio 1')},
{down = iCommandDynamicRadioFrequencyUp, value_down = 0.1, value_up = 0.0, name = _('r.1 Frequency up'), category = _('Radio 1')},
{down = iCommandDynamicRadioFrequencyDown, value_down = 0.1, value_up = 0.0, name = _('r.1 Frequency down'), category = _('Radio 1')},
{down = iCommandDynamicRadioChannelIncrease, value_down = 0.1, value_up = 0.0, name = _('r.1 Channel increase'), category = _('Radio 1')},
{down = iCommandDynamicRadioChannelDecrease, value_down = 0.1, value_up = 0.0, name = _('r.1 Channel decrease'), category = _('Radio 1')},
{down = iCommandDynamicRadioGuardChangeNext, value_down = 0.1, value_up = 0.0, name = _('r.1 Guard change'), category = _('Radio 1')},
{down = iCommandDynamicRadioEncryptionOnOff, value_down = 0.1, value_up = 0.0, name = _('r.1 Encryption On/Off'), category = _('Radio 1')},
{down = iCommandDynamicRadioPowerChangeNext, value_down = 0.1, value_up = 0.0, name = _('r.1 Power change'), category = _('Radio 1')},
{down = iCommandDynamicRadioSquelchOnOff, value_down = 0.1, value_up = 0.0, name = _('r.1 Squelch On/Off'), category = _('Radio 1')},
{down = iCommandDynamicRadioVolumeUp, value_down = 0.1, value_up = 0.0, name = _('r.1 Volume up'), category = _('Radio 1')},
{down = iCommandDynamicRadioVolumeDown, value_down = 0.1, value_up = 0.0, name = _('r.1 Volume down'), category = _('Radio 1')},
{down = iCommandDynamicRadioBalanceLeft, value_down = 0.1, value_up = 0.0, name = _('r.1 Balance left'), category = _('Radio 1')},
{down = iCommandDynamicRadioBalanceRight, value_down = 0.1, value_up = 0.0, name = _('r.1 Balance right'), category = _('Radio 1')},

-- RADIO 2
{down = iCommandDynamicRadioPushToTalkEnableVoice, up = iCommandDynamicRadioPushToTalkDisableVoice, value_down = 0.2, value_up = 0.0, name = _('r.2 VoIP PTT'), category = _('Radio 2')},
{down = iCommandDynamicRadioModulationNext, value_down = 0.2, value_up = 0.0, name = _('r.2 Modulation change'), category = _('Radio 2')},
{down = iCommandDynamicRadioFreqChangeSelectorNext, value_down = 0.2, value_up = 0.0, name = _('r.2 Frequency change selector'), category = _('Radio 2')},
{down = iCommandDynamicRadioFrequencyUp, value_down = 0.2, value_up = 0.0, name = _('r.2 Frequency up'), category = _('Radio 2')},
{down = iCommandDynamicRadioFrequencyDown, value_down = 0.2, value_up = 0.0, name = _('r.2 Frequency down'), category = _('Radio 2')},
{down = iCommandDynamicRadioChannelIncrease, value_down = 0.2, value_up = 0.0, name = _('r.2 Channel increase'), category = _('Radio 2')},
{down = iCommandDynamicRadioChannelDecrease, value_down = 0.2, value_up = 0.0, name = _('r.2 Channel decrease'), category = _('Radio 2')},
{down = iCommandDynamicRadioGuardChangeNext, value_down = 0.2, value_up = 0.0, name = _('r.2 Guard change'), category = _('Radio 2')},
{down = iCommandDynamicRadioEncryptionOnOff, value_down = 0.2, value_up = 0.0, name = _('r.2 Encryption On/Off'), category = _('Radio 2')},
{down = iCommandDynamicRadioPowerChangeNext, value_down = 0.2, value_up = 0.0, name = _('r.2 Power change'), category = _('Radio 2')},
{down = iCommandDynamicRadioSquelchOnOff, value_down = 0.2, value_up = 0.0, name = _('r.2 Squelch On/Off'), category = _('Radio 2')},
{down = iCommandDynamicRadioVolumeUp, value_down = 0.2, value_up = 0.0, name = _('r.2 Volume up'), category = _('Radio 2')},
{down = iCommandDynamicRadioVolumeDown, value_down = 0.2, value_up = 0.0, name = _('r.2 Volume down'), category = _('Radio 2')},
{down = iCommandDynamicRadioBalanceLeft, value_down = 0.2, value_up = 0.0, name = _('r.2 Balance left'), category = _('Radio 2')},
{down = iCommandDynamicRadioBalanceRight, value_down = 0.2, value_up = 0.0, name = _('r.2 Balance right'), category = _('Radio 2')},

-- RADIO 3
{down = iCommandDynamicRadioPushToTalkEnableVoice, up = iCommandDynamicRadioPushToTalkDisableVoice, value_down = 0.3, value_up = 0.0, name = _('r.3 VoIP PTT'), category = _('Radio 3')},
{down = iCommandDynamicRadioModulationNext, value_down = 0.3, value_up = 0.0, name = _('r.3 Modulation change'), category = _('Radio 3')},
{down = iCommandDynamicRadioFreqChangeSelectorNext, value_down = 0.3, value_up = 0.0, name = _('r.3 Frequency change selector'), category = _('Radio 3')},
{down = iCommandDynamicRadioFrequencyUp, value_down = 0.3, value_up = 0.0, name = _('r.3 Frequency up'), category = _('Radio 3')},
{down = iCommandDynamicRadioFrequencyDown, value_down = 0.3, value_up = 0.0, name = _('r.3 Frequency down'), category = _('Radio 3')},
{down = iCommandDynamicRadioChannelIncrease, value_down = 0.3, value_up = 0.0, name = _('r.3 Channel increase'), category = _('Radio 3')},
{down = iCommandDynamicRadioChannelDecrease, value_down = 0.3, value_up = 0.0, name = _('r.3 Channel decrease'), category = _('Radio 3')},
{down = iCommandDynamicRadioGuardChangeNext, value_down = 0.3, value_up = 0.0, name = _('r.3 Guard change'), category = _('Radio 3')},
{down = iCommandDynamicRadioEncryptionOnOff, value_down = 0.3, value_up = 0.0, name = _('r.3 Encryption On/Off'), category = _('Radio 3')},
{down = iCommandDynamicRadioPowerChangeNext, value_down = 0.3, value_up = 0.0, name = _('r.3 Power change'), category = _('Radio 3')},
{down = iCommandDynamicRadioSquelchOnOff, value_down = 0.3, value_up = 0.0, name = _('r.3 Squelch On/Off'), category = _('Radio 3')},
{down = iCommandDynamicRadioVolumeUp, value_down = 0.3, value_up = 0.0, name = _('r.3 Volume up'), category = _('Radio 3')},
{down = iCommandDynamicRadioVolumeDown, value_down = 0.3, value_up = 0.0, name = _('r.3 Volume down'), category = _('Radio 3')},
{down = iCommandDynamicRadioBalanceLeft, value_down = 0.3, value_up = 0.0, name = _('r.3 Balance left'), category = _('Radio 3')},
{down = iCommandDynamicRadioBalanceRight, value_down = 0.3, value_up = 0.0, name = _('r.3 Balance right'), category = _('Radio 3')},

-- RADIO 4
{down = iCommandDynamicRadioPushToTalkEnableVoice, up = iCommandDynamicRadioPushToTalkDisableVoice, value_down = 0.4, value_up = 0.0, name = _('r.4 VoIP PTT'), category = _('Radio 4')},
{down = iCommandDynamicRadioModulationNext, value_down = 0.4, value_up = 0.0, name = _('r.4 Modulation change'), category = _('Radio 4')},
{down = iCommandDynamicRadioFreqChangeSelectorNext, value_down = 0.4, value_up = 0.0, name = _('r.4 Frequency change selector'), category = _('Radio 4')},
{down = iCommandDynamicRadioFrequencyUp, value_down = 0.4, value_up = 0.0, name = _('r.4 Frequency up'), category = _('Radio 4')},
{down = iCommandDynamicRadioFrequencyDown, value_down = 0.4, value_up = 0.0, name = _('r.4 Frequency down'), category = _('Radio 4')},
{down = iCommandDynamicRadioChannelIncrease, value_down = 0.4, value_up = 0.0, name = _('r.4 Channel increase'), category = _('Radio 4')},
{down = iCommandDynamicRadioChannelDecrease, value_down = 0.4, value_up = 0.0, name = _('r.4 Channel decrease'), category = _('Radio 4')},
{down = iCommandDynamicRadioGuardChangeNext, value_down = 0.4, value_up = 0.0, name = _('r.4 Guard change'), category = _('Radio 4')},
{down = iCommandDynamicRadioEncryptionOnOff, value_down = 0.4, value_up = 0.0, name = _('r.4 Encryption On/Off'), category = _('Radio 4')},
{down = iCommandDynamicRadioPowerChangeNext, value_down = 0.4, value_up = 0.0, name = _('r.4 Power change'), category = _('Radio 4')},
{down = iCommandDynamicRadioSquelchOnOff, value_down = 0.4, value_up = 0.0, name = _('r.4 Squelch On/Off'), category = _('Radio 4')},
{down = iCommandDynamicRadioVolumeUp, value_down = 0.4, value_up = 0.0, name = _('r.4 Volume up'), category = _('Radio 4')},
{down = iCommandDynamicRadioVolumeDown, value_down = 0.4, value_up = 0.0, name = _('r.4 Volume down'), category = _('Radio 4')},
{down = iCommandDynamicRadioBalanceLeft, value_down = 0.4, value_up = 0.0, name = _('r.4 Balance left'), category = _('Radio 4')},
{down = iCommandDynamicRadioBalanceRight, value_down = 0.4, value_up = 0.0, name = _('r.4 Balance right'), category = _('Radio 4')},

-- RADIO 5
{down = iCommandDynamicRadioPushToTalkEnableVoice, up = iCommandDynamicRadioPushToTalkDisableVoice, value_down = 0.5, value_up = 0.0, name = _('r.5 VoIP PTT'), category = _('Radio 5')},
{down = iCommandDynamicRadioModulationNext, value_down = 0.5, value_up = 0.0, name = _('r.5 Modulation change'), category = _('Radio 5')},
{down = iCommandDynamicRadioFreqChangeSelectorNext, value_down = 0.5, value_up = 0.0, name = _('r.5 Frequency change selector'), category = _('Radio 5')},
{down = iCommandDynamicRadioFrequencyUp, value_down = 0.5, value_up = 0.0, name = _('r.5 Frequency up'), category = _('Radio 5')},
{down = iCommandDynamicRadioFrequencyDown, value_down = 0.5, value_up = 0.0, name = _('r.5 Frequency down'), category = _('Radio 5')},
{down = iCommandDynamicRadioChannelIncrease, value_down = 0.5, value_up = 0.0, name = _('r.5 Channel increase'), category = _('Radio 5')},
{down = iCommandDynamicRadioChannelDecrease, value_down = 0.5, value_up = 0.0, name = _('r.5 Channel decrease'), category = _('Radio 5')},
{down = iCommandDynamicRadioGuardChangeNext, value_down = 0.5, value_up = 0.0, name = _('r.5 Guard change'), category = _('Radio 5')},
{down = iCommandDynamicRadioEncryptionOnOff, value_down = 0.5, value_up = 0.0, name = _('r.5 Encryption On/Off'), category = _('Radio 5')},
{down = iCommandDynamicRadioPowerChangeNext, value_down = 0.5, value_up = 0.0, name = _('r.5 Power change'), category = _('Radio 5')},
{down = iCommandDynamicRadioSquelchOnOff, value_down = 0.5, value_up = 0.0, name = _('r.5 Squelch On/Off'), category = _('Radio 5')},
{down = iCommandDynamicRadioVolumeUp, value_down = 0.5, value_up = 0.0, name = _('r.5 Volume up'), category = _('Radio 5')},
{down = iCommandDynamicRadioVolumeDown, value_down = 0.5, value_up = 0.0, name = _('r.5 Volume down'), category = _('Radio 5')},
{down = iCommandDynamicRadioBalanceLeft, value_down = 0.5, value_up = 0.0, name = _('r.5 Balance left'), category = _('Radio 5')},
{down = iCommandDynamicRadioBalanceRight, value_down = 0.5, value_up = 0.0, name = _('r.5 Balance right'), category = _('Radio 5')},

-- RADIO 6
{down = iCommandDynamicRadioPushToTalkEnableVoice, up = iCommandDynamicRadioPushToTalkDisableVoice, value_down = 0.6, value_up = 0.0, name = _('r.6 VoIP PTT'), category = _('Radio 6')},
{down = iCommandDynamicRadioModulationNext, value_down = 0.6, value_up = 0.0, name = _('r.6 Modulation change'), category = _('Radio 6')},
{down = iCommandDynamicRadioFreqChangeSelectorNext, value_down = 0.6, value_up = 0.0, name = _('r.6 Frequency change selector'), category = _('Radio 6')},
{down = iCommandDynamicRadioFrequencyUp, value_down = 0.6, value_up = 0.0, name = _('r.6 Frequency up'), category = _('Radio 6')},
{down = iCommandDynamicRadioFrequencyDown, value_down = 0.6, value_up = 0.0, name = _('r.6 Frequency down'), category = _('Radio 6')},
{down = iCommandDynamicRadioChannelIncrease, value_down = 0.6, value_up = 0.0, name = _('r.6 Channel increase'), category = _('Radio 6')},
{down = iCommandDynamicRadioChannelDecrease, value_down = 0.6, value_up = 0.0, name = _('r.6 Channel decrease'), category = _('Radio 6')},
{down = iCommandDynamicRadioGuardChangeNext, value_down = 0.6, value_up = 0.0, name = _('r.6 Guard change'), category = _('Radio 6')},
{down = iCommandDynamicRadioEncryptionOnOff, value_down = 0.6, value_up = 0.0, name = _('r.6 Encryption On/Off'), category = _('Radio 6')},
{down = iCommandDynamicRadioPowerChangeNext, value_down = 0.6, value_up = 0.0, name = _('r.6 Power change'), category = _('Radio 6')},
{down = iCommandDynamicRadioSquelchOnOff, value_down = 0.6, value_up = 0.0, name = _('r.6 Squelch On/Off'), category = _('Radio 6')},
{down = iCommandDynamicRadioVolumeUp, value_down = 0.6, value_up = 0.0, name = _('r.6 Volume up'), category = _('Radio 6')},
{down = iCommandDynamicRadioVolumeDown, value_down = 0.6, value_up = 0.0, name = _('r.6 Volume down'), category = _('Radio 6')},
{down = iCommandDynamicRadioBalanceLeft, value_down = 0.6, value_up = 0.0, name = _('r.6 Balance left'), category = _('Radio 6')},
{down = iCommandDynamicRadioBalanceRight, value_down = 0.6, value_up = 0.0, name = _('r.6 Balance right'), category = _('Radio 6')},

-- RADIO 7
{down = iCommandDynamicRadioPushToTalkEnableVoice, up = iCommandDynamicRadioPushToTalkDisableVoice, value_down = 0.7, value_up = 0.0, name = _('r.7 VoIP PTT'), category = _('Radio 7')},
{down = iCommandDynamicRadioModulationNext, value_down = 0.7, value_up = 0.0, name = _('r.7 Modulation change'), category = _('Radio 7')},
{down = iCommandDynamicRadioFreqChangeSelectorNext, value_down = 0.7, value_up = 0.0, name = _('r.7 Frequency change selector'), category = _('Radio 7')},
{down = iCommandDynamicRadioFrequencyUp, value_down = 0.7, value_up = 0.0, name = _('r.7 Frequency up'), category = _('Radio 7')},
{down = iCommandDynamicRadioFrequencyDown, value_down = 0.7, value_up = 0.0, name = _('r.7 Frequency down'), category = _('Radio 7')},
{down = iCommandDynamicRadioChannelIncrease, value_down = 0.7, value_up = 0.0, name = _('r.7 Channel increase'), category = _('Radio 7')},
{down = iCommandDynamicRadioChannelDecrease, value_down = 0.7, value_up = 0.0, name = _('r.7 Channel decrease'), category = _('Radio 7')},
{down = iCommandDynamicRadioGuardChangeNext, value_down = 0.7, value_up = 0.0, name = _('r.7 Guard change'), category = _('Radio 7')},
{down = iCommandDynamicRadioEncryptionOnOff, value_down = 0.7, value_up = 0.0, name = _('r.7 Encryption On/Off'), category = _('Radio 7')},
{down = iCommandDynamicRadioPowerChangeNext, value_down = 0.7, value_up = 0.0, name = _('r.7 Power change'), category = _('Radio 7')},
{down = iCommandDynamicRadioSquelchOnOff, value_down = 0.7, value_up = 0.0, name = _('r.7 Squelch On/Off'), category = _('Radio 7')},
{down = iCommandDynamicRadioVolumeUp, value_down = 0.7, value_up = 0.0, name = _('r.7 Volume up'), category = _('Radio 7')},
{down = iCommandDynamicRadioVolumeDown, value_down = 0.7, value_up = 0.0, name = _('r.7 Volume down'), category = _('Radio 7')},
{down = iCommandDynamicRadioBalanceLeft, value_down = 0.7, value_up = 0.0, name = _('r.7 Balance left'), category = _('Radio 7')},
{down = iCommandDynamicRadioBalanceRight, value_down = 0.7, value_up = 0.0, name = _('r.7 Balance right'), category = _('Radio 7')},

-- RADIO 8
{down = iCommandDynamicRadioPushToTalkEnableVoice, up = iCommandDynamicRadioPushToTalkDisableVoice, value_down = 0.8, value_up = 0.0, name = _('r.8 VoIP PTT'), category = _('Radio 8')},
{down = iCommandDynamicRadioModulationNext, value_down = 0.8, value_up = 0.0, name = _('r.8 Modulation change'), category = _('Radio 8')},
{down = iCommandDynamicRadioFreqChangeSelectorNext, value_down = 0.8, value_up = 0.0, name = _('r.8 Frequency change selector'), category = _('Radio 8')},
{down = iCommandDynamicRadioFrequencyUp, value_down = 0.8, value_up = 0.0, name = _('r.8 Frequency up'), category = _('Radio 8')},
{down = iCommandDynamicRadioFrequencyDown, value_down = 0.8, value_up = 0.0, name = _('r.8 Frequency down'), category = _('Radio 8')},
{down = iCommandDynamicRadioChannelIncrease, value_down = 0.8, value_up = 0.0, name = _('r.8 Channel increase'), category = _('Radio 8')},
{down = iCommandDynamicRadioChannelDecrease, value_down = 0.8, value_up = 0.0, name = _('r.8 Channel decrease'), category = _('Radio 8')},
{down = iCommandDynamicRadioGuardChangeNext, value_down = 0.8, value_up = 0.0, name = _('r.8 Guard change'), category = _('Radio 8')},
{down = iCommandDynamicRadioEncryptionOnOff, value_down = 0.8, value_up = 0.0, name = _('r.8 Encryption On/Off'), category = _('Radio 8')},
{down = iCommandDynamicRadioPowerChangeNext, value_down = 0.8, value_up = 0.0, name = _('r.8 Power change'), category = _('Radio 8')},
{down = iCommandDynamicRadioSquelchOnOff, value_down = 0.8, value_up = 0.0, name = _('r.8 Squelch On/Off'), category = _('Radio 8')},
{down = iCommandDynamicRadioVolumeUp, value_down = 0.8, value_up = 0.0, name = _('r.8 Volume up'), category = _('Radio 8')},
{down = iCommandDynamicRadioVolumeDown, value_down = 0.8, value_up = 0.0, name = _('r.8 Volume down'), category = _('Radio 8')},
{down = iCommandDynamicRadioBalanceLeft, value_down = 0.8, value_up = 0.0, name = _('r.8 Balance left'), category = _('Radio 8')},
{down = iCommandDynamicRadioBalanceRight, value_down = 0.8, value_up = 0.0, name = _('r.8 Balance right'), category = _('Radio 8')},

-- RADIO 9
{down = iCommandDynamicRadioPushToTalkEnableVoice, up = iCommandDynamicRadioPushToTalkDisableVoice, value_down = 0.9, value_up = 0.0, name = _('r.9 VoIP PTT'), category = _('Radio 9')},
{down = iCommandDynamicRadioModulationNext, value_down = 0.9, value_up = 0.0, name = _('r.9 Modulation change'), category = _('Radio 9')},
{down = iCommandDynamicRadioFreqChangeSelectorNext, value_down = 0.9, value_up = 0.0, name = _('r.9 Frequency change selector'), category = _('Radio 9')},
{down = iCommandDynamicRadioFrequencyUp, value_down = 0.9, value_up = 0.0, name = _('r.9 Frequency up'), category = _('Radio 9')},
{down = iCommandDynamicRadioFrequencyDown, value_down = 0.9, value_up = 0.0, name = _('r.9 Frequency down'), category = _('Radio 9')},
{down = iCommandDynamicRadioChannelIncrease, value_down = 0.9, value_up = 0.0, name = _('r.9 Channel increase'), category = _('Radio 9')},
{down = iCommandDynamicRadioChannelDecrease, value_down = 0.9, value_up = 0.0, name = _('r.9 Channel decrease'), category = _('Radio 9')},
{down = iCommandDynamicRadioGuardChangeNext, value_down = 0.9, value_up = 0.0, name = _('r.9 Guard change'), category = _('Radio 9')},
{down = iCommandDynamicRadioEncryptionOnOff, value_down = 0.9, value_up = 0.0, name = _('r.9 Encryption On/Off'), category = _('Radio 9')},
{down = iCommandDynamicRadioPowerChangeNext, value_down = 0.9, value_up = 0.0, name = _('r.9 Power change'), category = _('Radio 9')},
{down = iCommandDynamicRadioSquelchOnOff, value_down = 0.9, value_up = 0.0, name = _('r.9 Squelch On/Off'), category = _('Radio 9')},
{down = iCommandDynamicRadioVolumeUp, value_down = 0.9, value_up = 0.0, name = _('r.9 Volume up'), category = _('Radio 9')},
{down = iCommandDynamicRadioVolumeDown, value_down = 0.9, value_up = 0.0, name = _('r.9 Volume down'), category = _('Radio 9')},
{down = iCommandDynamicRadioBalanceLeft, value_down = 0.9, value_up = 0.0, name = _('r.9 Balance left'), category = _('Radio 9')},
{down = iCommandDynamicRadioBalanceRight, value_down = 0.9, value_up = 0.0, name = _('r.9 Balance right'), category = _('Radio 9')},

},

axisCommands = {},
}