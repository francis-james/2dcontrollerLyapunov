/** THIS IS AN AUTOMATICALLY GENERATED FILE.  DO NOT MODIFY
 * BY HAND!!
 *
 * Generated by lcm-gen
 **/

#include <lcm/lcm_coretypes.h>

#ifndef __drake_lcmt_whole_body_data_hpp__
#define __drake_lcmt_whole_body_data_hpp__

#include <vector>

namespace drake
{

class lcmt_whole_body_data
{
    public:
        int64_t    timestamp;
        int32_t    num_positions;
        std::vector< double > q_des;
        int32_t    num_constrained_dofs;
        std::vector< int32_t > constrained_dofs;

    public:
        inline int encode(void *buf, int offset, int maxlen) const;
        inline int getEncodedSize() const;
        inline int decode(const void *buf, int offset, int maxlen);
        inline static int64_t getHash();
        inline static const char* getTypeName();

        // LCM support functions. Users should not call these
        inline int _encodeNoHash(void *buf, int offset, int maxlen) const;
        inline int _getEncodedSizeNoHash() const;
        inline int _decodeNoHash(const void *buf, int offset, int maxlen);
        inline static int64_t _computeHash(const __lcm_hash_ptr *p);
};

int lcmt_whole_body_data::encode(void *buf, int offset, int maxlen) const
{
    int pos = 0, tlen;
    int64_t hash = getHash();

    tlen = __int64_t_encode_array(buf, offset + pos, maxlen - pos, &hash, 1);
    if(tlen < 0) return tlen; else pos += tlen;

    tlen = this->_encodeNoHash(buf, offset + pos, maxlen - pos);
    if (tlen < 0) return tlen; else pos += tlen;

    return pos;
}

int lcmt_whole_body_data::decode(const void *buf, int offset, int maxlen)
{
    int pos = 0, thislen;

    int64_t msg_hash;
    thislen = __int64_t_decode_array(buf, offset + pos, maxlen - pos, &msg_hash, 1);
    if (thislen < 0) return thislen; else pos += thislen;
    if (msg_hash != getHash()) return -1;

    thislen = this->_decodeNoHash(buf, offset + pos, maxlen - pos);
    if (thislen < 0) return thislen; else pos += thislen;

    return pos;
}

int lcmt_whole_body_data::getEncodedSize() const
{
    return 8 + _getEncodedSizeNoHash();
}

int64_t lcmt_whole_body_data::getHash()
{
    static int64_t hash = _computeHash(NULL);
    return hash;
}

const char* lcmt_whole_body_data::getTypeName()
{
    return "lcmt_whole_body_data";
}

int lcmt_whole_body_data::_encodeNoHash(void *buf, int offset, int maxlen) const
{
    int pos = 0, tlen;

    tlen = __int64_t_encode_array(buf, offset + pos, maxlen - pos, &this->timestamp, 1);
    if(tlen < 0) return tlen; else pos += tlen;

    tlen = __int32_t_encode_array(buf, offset + pos, maxlen - pos, &this->num_positions, 1);
    if(tlen < 0) return tlen; else pos += tlen;

    tlen = __double_encode_array(buf, offset + pos, maxlen - pos, &this->q_des[0], this->num_positions);
    if(tlen < 0) return tlen; else pos += tlen;

    tlen = __int32_t_encode_array(buf, offset + pos, maxlen - pos, &this->num_constrained_dofs, 1);
    if(tlen < 0) return tlen; else pos += tlen;

    tlen = __int32_t_encode_array(buf, offset + pos, maxlen - pos, &this->constrained_dofs[0], this->num_constrained_dofs);
    if(tlen < 0) return tlen; else pos += tlen;

    return pos;
}

int lcmt_whole_body_data::_decodeNoHash(const void *buf, int offset, int maxlen)
{
    int pos = 0, tlen;

    tlen = __int64_t_decode_array(buf, offset + pos, maxlen - pos, &this->timestamp, 1);
    if(tlen < 0) return tlen; else pos += tlen;

    tlen = __int32_t_decode_array(buf, offset + pos, maxlen - pos, &this->num_positions, 1);
    if(tlen < 0) return tlen; else pos += tlen;

    this->q_des.resize(this->num_positions);
    if(this->num_positions) {
        tlen = __double_decode_array(buf, offset + pos, maxlen - pos, &this->q_des[0], this->num_positions);
        if(tlen < 0) return tlen; else pos += tlen;
    }

    tlen = __int32_t_decode_array(buf, offset + pos, maxlen - pos, &this->num_constrained_dofs, 1);
    if(tlen < 0) return tlen; else pos += tlen;

    this->constrained_dofs.resize(this->num_constrained_dofs);
    if(this->num_constrained_dofs) {
        tlen = __int32_t_decode_array(buf, offset + pos, maxlen - pos, &this->constrained_dofs[0], this->num_constrained_dofs);
        if(tlen < 0) return tlen; else pos += tlen;
    }

    return pos;
}

int lcmt_whole_body_data::_getEncodedSizeNoHash() const
{
    int enc_size = 0;
    enc_size += __int64_t_encoded_array_size(NULL, 1);
    enc_size += __int32_t_encoded_array_size(NULL, 1);
    enc_size += __double_encoded_array_size(NULL, this->num_positions);
    enc_size += __int32_t_encoded_array_size(NULL, 1);
    enc_size += __int32_t_encoded_array_size(NULL, this->num_constrained_dofs);
    return enc_size;
}

int64_t lcmt_whole_body_data::_computeHash(const __lcm_hash_ptr *)
{
    int64_t hash = 0x0ec1b6910198d358LL;
    return (hash<<1) + ((hash>>63)&1);
}

}

#endif