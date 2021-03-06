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
  23: ds_packet_class
  24: us_service_flow
  25: ds_service_flow
  26: phs
  28: max_classifiers
  29: global_privacy_enable
  32: manufacturer_cvc
  33: cosigner_cvc
  34: snmpv3_kickstart
  35: sub_mgmt_control
  39: docsis20_enable
  40: enable_test_modes
  41: ds_channel_list
  42: multicast_mac_address
  43: vendor_specific
  58: sw_upgrade_server6
  254: mta_config_delimiter  
 
 baseline_privacy:
  1: auth_timeout
  2: reauth_timeout
  3: auth_grace_time
  4: oper_timeout
  5: rekey_timeout
  6: tek_grace_time
  7: auth_reject_timeout
  8: sa_map_wait_timeout
  9: sa_max_max_retries

 packet_class:
  1: classifier_ref
  2: classifier_id
  3: service_flow_ref
  4: service_flow_id
  5: rule_priority
  6: activation_state
  7: dsc_action
  9: ip_packet_classifier
  10: llc_packet_classifier
  11: ieee802_classifier
  12: pc_ipv6_packet_classification
  13: pc_cmime_encoding
  14: s_tag_c_tag_frame_classification
  15: ieee802ah_packet_classification
  16: icmpv4_icmpv6_packet_classification
  17: mpls_classification_encoding
  43: vendor_specific

 us_service_flow:
  1: us_service_flow_ref
  2: us_service_flow_id
  3: service_identifier
  4: service_class_name
  6: qos_param_set_type
  7: traffic_priority
  8: max_rate_sustained
  9: max_traffic_burst
  10: min_reserved_rate
  11: min_res_packet_size
  12: act_qos_params_timeout
  13: adm_qos_params_timeout
  14: max_concatenated_burst
  15: scheduling_type
  16: request_or_tx_policy
  17: nominal_poll_interval
  18: tolerated_poll_jitter
  19: unsolicited_grant_size
  20: nominal_grant_interval
  21: tolerated_grant_jitter
  22: grants_per_interval
  23: ip_tos_overwrite
  26: multiplier_to_no_of_bytes_requested
  27: upstream_traffic_peak_rate
  31: sf_required_attribute_mask
  32: sf_forbidden_attribute_mask
  33: sf_attribute_aggregation_rule_mask
  34: application_identifier
  35: buffer_control
  36: upstream_aggregate_sf_reference
  37: upstream_mes_preference
  40: aqm_encodings
  41: data_rate_unit_setting
  43: vendor_specific
 
 ip_packet_classifier:
  1: ip_tos
  2: ip_proto
  3: ip_src_addr
  4: ip_src_mask
  5: ip_dst_addr
  6: ip_dst_mask
  7: src_port_start
  8: src_port_end
  9: dst_port_start
  10: dst_port_end

 llc_packet_classifier:
  1: dst_mac_address
  2: src_mac_address
  3: ether_type

 ieee802_classifier:
  1: user_priority
  2: vlan_id

 

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
     if: tlv_type != tlv_types::pad
   - id: tlv_value
     size: length
     type:
      switch-on: tlv_type
      cases:
       'tlv_types::baseline_privacy': tlvs_baseline_privacy
       'tlv_types::us_packet_class': tlvs_packet_class
       'tlv_types::ds_packet_class': tlvs_packet_class
       'tlv_types::us_service_flow': tlvs_us_service_flow
       'tlv_types::snmp_mib_object': tlv_snmp
     if: tlv_type != tlv_types::pad

 tlvs_baseline_privacy:
  seq:
   - id: tlvs
     type: tlv_baseline_privacy
     repeat: eos

 tlvs_packet_class:
  seq:
   - id: tlvs
     type: tlv_packet_class
     repeat: eos

 tlvs_ip_packet_classifier:
  seq:
   - id: tlvs
     type: tlv_ip_packet_classifier
     repeat: eos

 tlvs_us_service_flow:
  seq:
   - id: tlvs
     type: tlv_us_service_flow
     repeat: eos

 tlv_baseline_privacy:
  seq:
   - id: tlv_type
     type: u1
     enum: baseline_privacy
   - id: length
     type: u1
   - id: value
     size: length
     type:
      switch-on: length
      cases:
       4: u4be

 tlv_packet_class:
  seq:
   - id: tlv_type
     type: u1
     enum: packet_class
   - id: length
     type: u1
   - id: value
     size: length
     type:
      switch-on: tlv_type
      cases:
       'packet_class::ip_packet_classifier': tlvs_ip_packet_classifier

 tlv_ip_packet_classifier:
  seq:
   - id: tlv_type
     type: u1
     enum: ip_packet_classifier
   - id: length
     type: u1
   - id: value
     size: length

 tlv_us_service_flow:
  seq:
   - id: tlv_type
     type: u1
     enum: us_service_flow
   - id: length
     type: u1
   - id: value
     size: length
     type:
      switch-on: tlv_type
      cases:
       'us_service_flow::us_service_flow_ref': u2be
       'us_service_flow::qos_param_set_type': u1
       'us_service_flow::scheduling_type': u1
       'us_service_flow::max_rate_sustained': u4be

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
