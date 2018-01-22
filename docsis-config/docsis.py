# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

import array
import struct
import zlib
from enum import Enum
from pkg_resources import parse_version

from kaitaistruct import __version__ as ks_version, KaitaiStruct, KaitaiStream, BytesIO


if parse_version(ks_version) < parse_version('0.7'):
    raise Exception("Incompatible Kaitai Struct Python API: 0.7 or later is required, but you have %s" % (ks_version))

class Docsis(KaitaiStruct):

    class BaselinePrivacy(Enum):
        auth_timeout = 1
        reauth_timeout = 2
        auth_grace_time = 3
        oper_timeout = 4
        rekey_timeout = 5
        tek_grace_time = 6
        auth_reject_timeout = 7
        sa_map_wait_timeout = 8
        sa_max_max_retries = 9

    class PacketClass(Enum):
        classifier_ref = 1
        classifier_id = 2
        service_flow_ref = 3
        service_flow_id = 4
        rule_priority = 5
        activation_state = 6
        dsc_action = 7
        ip_packet_classifier = 9
        llc_packet_classifier = 10
        ieee802_classifier = 11
        pc_ipv6_packet_classification = 12
        pc_cmime_encoding = 13
        s_tag_c_tag_frame_classification = 14
        ieee802ah_packet_classification = 15
        icmpv4_icmpv6_packet_classification = 16
        mpls_classification_encoding = 17
        vendor_specific = 43

    class Ieee802Classifier(Enum):
        user_priority = 1
        vlan_id = 2

    class LlcPacketClassifier(Enum):
        dst_mac_address = 1
        src_mac_address = 2
        ether_type = 3

    class TlvTypes(Enum):
        downstream_frequency = 1
        upstream_channel_id = 2
        network_access = 3
        class_of_service = 4
        modem_capabilities = 5
        cm_mic = 6
        cmts_mic = 7
        sw_upgrade_filename = 9
        snmp_write_control = 10
        snmp_mib_object = 11
        modem_ip_address = 12
        cpe_mac_address = 14
        baseline_privacy = 17
        max_cpe = 18
        tftp_timestamp = 19
        tftp_modem_address = 20
        sw_upgrade_server = 21
        us_packet_class = 22
        ds_packet_class = 23
        us_service_flow = 24
        ds_service_flow = 25
        phs = 26
        max_classifiers = 28
        global_privacy_enable = 29
        manufacturer_cvc = 32
        cosigner_cvc = 33
        snmpv3_kickstart = 34
        sub_mgmt_control = 35
        docsis20_enable = 39
        enable_test_modes = 40
        ds_channel_list = 41
        multicast_mac_address = 42
        vendor_specific = 43
        sw_upgrade_server6 = 58
        mta_config_delimiter = 254
        pad = 255

    class IpPacketClassifier(Enum):
        ip_tos = 1
        ip_proto = 2
        ip_src_addr = 3
        ip_src_mask = 4
        ip_dst_addr = 5
        ip_dst_mask = 6
        src_port_start = 7
        src_port_end = 8
        dst_port_start = 9
        dst_port_end = 10
    def __init__(self, _io, _parent=None, _root=None):
        self._io = _io
        self._parent = _parent
        self._root = _root if _root else self
        self.tlvs = []
        while not self._io.is_eof():
            self.tlvs.append(self._root.Tlv(self._io, self, self._root))


    class SnmpObject(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self.unknown1 = self._io.read_u1()
            self.length1 = self._io.read_u1()
            self.oid = self._io.read_bytes(self.length1)
            self.unknown2 = self._io.read_u1()
            self.length2 = self._io.read_u1()
            self.value = self._io.read_bytes(self.length2)


    class TlvIpPacketClassifier(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self.tlv_type = self._root.IpPacketClassifier(self._io.read_u1())
            self.length = self._io.read_u1()
            self.value = self._io.read_bytes(self.length)


    class Tlv(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self.tlv_type = self._root.TlvTypes(self._io.read_u1())
            if self.tlv_type == self._root.TlvTypes.pad:
                self.padding = self._io.read_bytes_full()

            if self.tlv_type != self._root.TlvTypes.pad:
                self.length = self._io.read_u1()

            if self.tlv_type != self._root.TlvTypes.pad:
                _on = self.tlv_type
                if _on == self._root.TlvTypes.snmp_mib_object:
                    self._raw_tlv_value = self._io.read_bytes(self.length)
                    io = KaitaiStream(BytesIO(self._raw_tlv_value))
                    self.tlv_value = self._root.TlvSnmp(io, self, self._root)
                elif _on == self._root.TlvTypes.baseline_privacy:
                    self._raw_tlv_value = self._io.read_bytes(self.length)
                    io = KaitaiStream(BytesIO(self._raw_tlv_value))
                    self.tlv_value = self._root.TlvsBaselinePrivacy(io, self, self._root)
                elif _on == self._root.TlvTypes.us_packet_class:
                    self._raw_tlv_value = self._io.read_bytes(self.length)
                    io = KaitaiStream(BytesIO(self._raw_tlv_value))
                    self.tlv_value = self._root.TlvsPacketClass(io, self, self._root)
                elif _on == self._root.TlvTypes.ds_packet_class:
                    self._raw_tlv_value = self._io.read_bytes(self.length)
                    io = KaitaiStream(BytesIO(self._raw_tlv_value))
                    self.tlv_value = self._root.TlvsPacketClass(io, self, self._root)
                else:
                    self.tlv_value = self._io.read_bytes(self.length)



    class TlvSnmp(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self.unknown1 = self._io.read_u1()
            self.len = self._io.read_u1()
            self._raw_val = self._io.read_bytes(self.len)
            io = KaitaiStream(BytesIO(self._raw_val))
            self.val = self._root.SnmpObject(io, self, self._root)


    class TlvsIpPacketClassifier(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self.tlvs = []
            while not self._io.is_eof():
                self.tlvs.append(self._root.TlvIpPacketClassifier(self._io, self, self._root))



    class TlvsBaselinePrivacy(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self.tlvs = []
            while not self._io.is_eof():
                self.tlvs.append(self._root.TlvBaselinePrivacy(self._io, self, self._root))



    class TlvsPacketClass(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self.tlvs = []
            while not self._io.is_eof():
                self.tlvs.append(self._root.TlvPacketClass(self._io, self, self._root))



    class TlvBaselinePrivacy(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self.tlv_type = self._root.BaselinePrivacy(self._io.read_u1())
            self.length = self._io.read_u1()
            _on = self.length
            if _on == 4:
                self.value = self._io.read_u4be()
            else:
                self.value = self._io.read_bytes(self.length)


    class TlvPacketClass(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self.tlv_type = self._root.PacketClass(self._io.read_u1())
            self.length = self._io.read_u1()
            _on = self.tlv_type
            if _on == self._root.PacketClass.ip_packet_classifier:
                self._raw_value = self._io.read_bytes(self.length)
                io = KaitaiStream(BytesIO(self._raw_value))
                self.value = self._root.TlvsIpPacketClassifier(io, self, self._root)
            else:
                self.value = self._io.read_bytes(self.length)



