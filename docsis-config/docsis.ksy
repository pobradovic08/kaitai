meta:
 id: docsis
 title: DOCSIS config file
 file-extension:
  - bin
 license: GPL-3.0-or-later
 encoding: UTF-8
 endian: le

seq:
 - id: tlvs
   type: tlv
   repeat: eos

enums:
 tlv_types:
  0xff: pad
  1: downstream_frequency
  2: upstream_channel_id
  3: network_access
  4: class_of_service
  5: modem_capabilities
  6: cm_mic
  7: cmts_mic
  9: sw_upgrade_filename
  10: snmp_write_control
  11: snmp_mib_object
  12: modem_ip_address
  14: cpe_mac_address 
  17: baseline_privacy
  18: max_cpe
  19: tftp_timestamp
  20: tftp_modem_address
  21: sw_upgrade_server
  22: us_packet_class
  
 
 tlv_bpi_types:
  1: auth_timeout
  2: reauth_timeout
  3: auth_grace_time
  4: oper_timeout
  5: rekey_timeout
  6: tek_grace_time
  7: auth_reject_timeout
  8: sa_map_wait_timeout
  9: sa_max_max_retries

 us_packet_class:
  1: classifier_ref
  2: classifier_id
  3: service_flow_ref
  4: service_flow_id
  5: rule_priority
  6: activation_state
  7: dsc_action
  9: ip_packet_classifier
  

types:
 tlv:
  seq:
   - id: tlv_type
     type: u1
     enum: tlv_types
   - id: padding
     size-eos: true
     if: tlv_type == tlv_types::pad
   - id: length
     type: u1
   - id: tlv_value
     size: length
     type:
      switch-on: tlv_type
      cases:
       'tlv_types::baseline_privacy': tlvs_bpi
       'tlv_types::snmp_mib_object': tlv_snmp
     if: length > 0
   - id: tlv_empty_value
     type: u1
     if: length == 0

 tlvs_bpi:
  seq:
   - id: tlvs
     type: tlv_bpi
     repeat: eos
 tlv_bpi:
  seq:
   - id: tlv_type
     type: u1
     enum: tlv_bpi_types
   - id: length
     type: u1
   - id: value
     size: length
     type:
      switch-on: length
      cases:
       4: u4be
 tlv_snmp:
  seq:
   - id: unknown1
     type: u1
   - id: len
     type: u1
   - id: val
     size: len
     type: snmp_object
 snmp_object:
  seq:
   - id: unknown1
     type: u1
   - id: length1
     type: u1
   - id: oid
     size: length1
   - id: unknown2
     type: u1
   - id: length2
     type: u1
   - id: value
     size: length2
