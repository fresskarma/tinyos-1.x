/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#ifndef _BUNDLE_COMMON_H_RPCGEN
#define _BUNDLE_COMMON_H_RPCGEN

#include <rpc/rpc.h>


#ifdef __cplusplus
extern "C" {
#endif

#define MAX_BUNDLE 1048576
#define MAX_TUPLE 65536
#define MAX_BUNDLE_FNAME PATH_MAX
#define MAX_EXEC_LEN ARG_MAX
#define MAX_AUTHDATA 1024
#define MAX_LOCAL_REGIONS 32
#define MAX_REGION_LEN 64
#define MAX_INFO_REQ 65536
#define MAX_INFO_RESULT 65536

typedef uint32_t BUNDLE_ITERATOR;

typedef uint32_t BUNDLE_STATUS;
#define BUNDLE_STATUS_BASE 128
#define BUNDLE_SUCCESS (BUNDLE_STATUS_BASE+0) /* ok */
#define BUNDLE_TOOBIG (BUNDLE_STATUS_BASE+1) /* payload too large */
#define BUNDLE_NOTFOUND (BUNDLE_STATUS_BASE+2) /* not found: (eg:file) */
#define BUNDLE_PERMS (BUNDLE_STATUS_BASE+3) /* permissions problem of some kind */
#define BUNDLE_EXISTS (BUNDLE_STATUS_BASE+4) /* bundle already being sent? */
#define BUNDLE_TPROB (BUNDLE_STATUS_BASE+5) /* tuple problem (too long) */
#define BUNDLE_NODATA (BUNDLE_STATUS_BASE+6) /* data missing/ too short */
#define BUNDLE_DISPERR (BUNDLE_STATUS_BASE+7) /* err delivering to local app */
#define BUNDLE_SPECERR (BUNDLE_STATUS_BASE+8) /* bad bundle spec */
#define BUNDLE_SERVERR (BUNDLE_STATUS_BASE+9) /* server error (eg failed syscall) */
#define BUNDLE_SMEMERR (BUNDLE_STATUS_BASE+10) /* server memory error [malloc failure] */
#define BUNDLE_RTPROB (BUNDLE_STATUS_BASE+11) /* trouble forwarding message at agent */
#define BUNDLE_BADCOOKIE (BUNDLE_STATUS_BASE+12) /* bad cookie provided by app */

struct BUNDLE_RESULT {
	BUNDLE_STATUS status;
};
typedef struct BUNDLE_RESULT BUNDLE_RESULT;

enum BUNDLE_REG_ACTION {
	BUNDLE_REG_ABORT = 1,
	BUNDLE_REG_DEFER = 2,
	BUNDLE_REG_EXEC = 3,
	BUNDLE_REG_CANCEL = 4,
};
typedef enum BUNDLE_REG_ACTION BUNDLE_REG_ACTION;
#define BUNDLE_REG_COOKIE_NONE 0x0

enum BUNDLE_COS {
	COS_BULK = 0,
	COS_NORMAL = 1,
	COS_EXPEDITED = 2,
	COS_RESERVED = 3,
};
typedef enum BUNDLE_COS BUNDLE_COS;

enum BUNDLE_INFREQ {
	BUNDLE_INFREQ_INTERFACE = 0,
};
typedef enum BUNDLE_INFREQ BUNDLE_INFREQ;

enum BUNDLE_DELIVERY_OPTS {
	COS_NONE = 0,
	COS_CUSTODY = 1,
	COS_RET_RCPT = 2,
	COS_DELIV_REC_FORW = 4,
	COS_DELIV_REC_CUST = 8,
};
typedef enum BUNDLE_DELIVERY_OPTS BUNDLE_DELIVERY_OPTS;

struct BUNDLE_TUPLE {
	struct {
		u_int name_len;
		char *name_val;
	} name;
	uint16_t admin_offset;
};
typedef struct BUNDLE_TUPLE BUNDLE_TUPLE;

struct BUNDLE_AUTHDATA {
	struct {
		u_int blob_len;
		char *blob_val;
	} blob;
};
typedef struct BUNDLE_AUTHDATA BUNDLE_AUTHDATA;

struct BUNDLE_SPEC {
	BUNDLE_COS cos;
	BUNDLE_DELIVERY_OPTS dopts;
	BUNDLE_TUPLE source;
	BUNDLE_TUPLE dest;
	BUNDLE_TUPLE reply_to;
	int32_t expire;
};
typedef struct BUNDLE_SPEC BUNDLE_SPEC;

struct BUNDLE_WAITING {
	BUNDLE_SPEC bs;
	struct {
		u_int filename_len;
		char *filename_val;
	} filename;
};
typedef struct BUNDLE_WAITING BUNDLE_WAITING;

struct BUNDLE_APP_ENDPOINT {
	struct {
		u_int hostname_len;
		char *hostname_val;
	} hostname;
	uint32_t id;
};
typedef struct BUNDLE_APP_ENDPOINT BUNDLE_APP_ENDPOINT;
#define BUNDLE_ITERATOR_NONE 0x0

struct BUNDLE_POLL_RESULT {
	BUNDLE_STATUS status;
	BUNDLE_WAITING bundle;
	BUNDLE_ITERATOR iterator;
};
typedef struct BUNDLE_POLL_RESULT BUNDLE_POLL_RESULT;

struct BUNDLE_REG_RESULT {
	BUNDLE_STATUS status;
	uint32_t cookie;
};
typedef struct BUNDLE_REG_RESULT BUNDLE_REG_RESULT;

struct BUNDLE_INFO_RESULT {
	BUNDLE_STATUS status;
	struct {
		u_int data_len;
		char *data_val;
	} data;
};
typedef struct BUNDLE_INFO_RESULT BUNDLE_INFO_RESULT;

typedef CLIENT *BUNDLE_AGENT;

typedef CLIENT *BUNDLE_APP;
#define ASSIGN_OPAQUE(obj,field,s,len) { (obj).field.field ## _val = (s); (obj).field.field ## _len = (len); }
#define OPAQUE_NULL(obj,field) { ASSIGN_OPAQUE((obj),field,NULL,0); }
#define TUPLE_LEN(tup) ((tup).name.name_len)
#define TUPLE_VAL(tup) ((tup).name.name_val)
#define TUPLE_ADMIN_OFFSET(tup) ((tup).admin_offset)

struct mem_bundle_req {
	BUNDLE_SPEC spec;
	struct {
		u_int buf_len;
		char *buf_val;
	} buf;
};
typedef struct mem_bundle_req mem_bundle_req;

struct file_bundle_req {
	BUNDLE_SPEC spec;
	struct {
		u_int filename_len;
		char *filename_val;
	} filename;
};
typedef struct file_bundle_req file_bundle_req;

struct reg_bundle_req {
	uint32_t timeout;
	BUNDLE_TUPLE name;
	BUNDLE_REG_ACTION action;
	uint32_t cookie;
	BUNDLE_APP_ENDPOINT endpoint;
	struct {
		u_int args_len;
		char *args_val;
	} args;
};
typedef struct reg_bundle_req reg_bundle_req;

struct poll_bundle_req {
	BUNDLE_TUPLE name;
	BUNDLE_ITERATOR iterator;
};
typedef struct poll_bundle_req poll_bundle_req;

struct info_bundle_req {
	BUNDLE_INFREQ code;
	struct {
		u_int args_len;
		char *args_val;
	} args;
};
typedef struct info_bundle_req info_bundle_req;

#define BUNDLE_PROG 200100
#define BUNDLE_VERS 1

#if defined(__STDC__) || defined(__cplusplus)
#define SEND_BUNDLE_MEM 1
extern  BUNDLE_RESULT * send_bundle_mem_1(mem_bundle_req *, CLIENT *);
extern  BUNDLE_RESULT * send_bundle_mem_1_svc(mem_bundle_req *, struct svc_req *);
#define SEND_BUNDLE_FILE 2
extern  BUNDLE_RESULT * send_bundle_file_1(file_bundle_req *, CLIENT *);
extern  BUNDLE_RESULT * send_bundle_file_1_svc(file_bundle_req *, struct svc_req *);
#define BUNDLE_REGISTER 3
extern  BUNDLE_REG_RESULT * bundle_register_1(reg_bundle_req *, CLIENT *);
extern  BUNDLE_REG_RESULT * bundle_register_1_svc(reg_bundle_req *, struct svc_req *);
#define BUNDLE_POLL 4
extern  BUNDLE_POLL_RESULT * bundle_poll_1(poll_bundle_req *, CLIENT *);
extern  BUNDLE_POLL_RESULT * bundle_poll_1_svc(poll_bundle_req *, struct svc_req *);
#define BUNDLE_GETINFO 5
extern  BUNDLE_INFO_RESULT * bundle_getinfo_1(info_bundle_req *, CLIENT *);
extern  BUNDLE_INFO_RESULT * bundle_getinfo_1_svc(info_bundle_req *, struct svc_req *);
extern int bundle_prog_1_freeresult (SVCXPRT *, xdrproc_t, caddr_t);

#else /* K&R C */
#define SEND_BUNDLE_MEM 1
extern  BUNDLE_RESULT * send_bundle_mem_1();
extern  BUNDLE_RESULT * send_bundle_mem_1_svc();
#define SEND_BUNDLE_FILE 2
extern  BUNDLE_RESULT * send_bundle_file_1();
extern  BUNDLE_RESULT * send_bundle_file_1_svc();
#define BUNDLE_REGISTER 3
extern  BUNDLE_REG_RESULT * bundle_register_1();
extern  BUNDLE_REG_RESULT * bundle_register_1_svc();
#define BUNDLE_POLL 4
extern  BUNDLE_POLL_RESULT * bundle_poll_1();
extern  BUNDLE_POLL_RESULT * bundle_poll_1_svc();
#define BUNDLE_GETINFO 5
extern  BUNDLE_INFO_RESULT * bundle_getinfo_1();
extern  BUNDLE_INFO_RESULT * bundle_getinfo_1_svc();
extern int bundle_prog_1_freeresult ();
#endif /* K&R C */

#define BUNDLE_DEMUX_PROG 200200
#define BUNDLE_DEMUX_VERS 1

#if defined(__STDC__) || defined(__cplusplus)
#define BUNDLE_ARRIVED 1
extern  BUNDLE_RESULT * bundle_arrived_1(BUNDLE_WAITING *, CLIENT *);
extern  BUNDLE_RESULT * bundle_arrived_1_svc(BUNDLE_WAITING *, struct svc_req *);
extern int bundle_demux_prog_1_freeresult (SVCXPRT *, xdrproc_t, caddr_t);

#else /* K&R C */
#define BUNDLE_ARRIVED 1
extern  BUNDLE_RESULT * bundle_arrived_1();
extern  BUNDLE_RESULT * bundle_arrived_1_svc();
extern int bundle_demux_prog_1_freeresult ();
#endif /* K&R C */

/* the xdr functions */

#if defined(__STDC__) || defined(__cplusplus)
extern  bool_t xdr_BUNDLE_ITERATOR (XDR *, BUNDLE_ITERATOR*);
extern  bool_t xdr_BUNDLE_STATUS (XDR *, BUNDLE_STATUS*);
extern  bool_t xdr_BUNDLE_RESULT (XDR *, BUNDLE_RESULT*);
extern  bool_t xdr_BUNDLE_REG_ACTION (XDR *, BUNDLE_REG_ACTION*);
extern  bool_t xdr_BUNDLE_COS (XDR *, BUNDLE_COS*);
extern  bool_t xdr_BUNDLE_INFREQ (XDR *, BUNDLE_INFREQ*);
extern  bool_t xdr_BUNDLE_DELIVERY_OPTS (XDR *, BUNDLE_DELIVERY_OPTS*);
extern  bool_t xdr_BUNDLE_TUPLE (XDR *, BUNDLE_TUPLE*);
extern  bool_t xdr_BUNDLE_AUTHDATA (XDR *, BUNDLE_AUTHDATA*);
extern  bool_t xdr_BUNDLE_SPEC (XDR *, BUNDLE_SPEC*);
extern  bool_t xdr_BUNDLE_WAITING (XDR *, BUNDLE_WAITING*);
extern  bool_t xdr_BUNDLE_APP_ENDPOINT (XDR *, BUNDLE_APP_ENDPOINT*);
extern  bool_t xdr_BUNDLE_POLL_RESULT (XDR *, BUNDLE_POLL_RESULT*);
extern  bool_t xdr_BUNDLE_REG_RESULT (XDR *, BUNDLE_REG_RESULT*);
extern  bool_t xdr_BUNDLE_INFO_RESULT (XDR *, BUNDLE_INFO_RESULT*);
extern  bool_t xdr_BUNDLE_AGENT (XDR *, BUNDLE_AGENT*);
extern  bool_t xdr_BUNDLE_APP (XDR *, BUNDLE_APP*);
extern  bool_t xdr_mem_bundle_req (XDR *, mem_bundle_req*);
extern  bool_t xdr_file_bundle_req (XDR *, file_bundle_req*);
extern  bool_t xdr_reg_bundle_req (XDR *, reg_bundle_req*);
extern  bool_t xdr_poll_bundle_req (XDR *, poll_bundle_req*);
extern  bool_t xdr_info_bundle_req (XDR *, info_bundle_req*);

#else /* K&R C */
extern bool_t xdr_BUNDLE_ITERATOR ();
extern bool_t xdr_BUNDLE_STATUS ();
extern bool_t xdr_BUNDLE_RESULT ();
extern bool_t xdr_BUNDLE_REG_ACTION ();
extern bool_t xdr_BUNDLE_COS ();
extern bool_t xdr_BUNDLE_INFREQ ();
extern bool_t xdr_BUNDLE_DELIVERY_OPTS ();
extern bool_t xdr_BUNDLE_TUPLE ();
extern bool_t xdr_BUNDLE_AUTHDATA ();
extern bool_t xdr_BUNDLE_SPEC ();
extern bool_t xdr_BUNDLE_WAITING ();
extern bool_t xdr_BUNDLE_APP_ENDPOINT ();
extern bool_t xdr_BUNDLE_POLL_RESULT ();
extern bool_t xdr_BUNDLE_REG_RESULT ();
extern bool_t xdr_BUNDLE_INFO_RESULT ();
extern bool_t xdr_BUNDLE_AGENT ();
extern bool_t xdr_BUNDLE_APP ();
extern bool_t xdr_mem_bundle_req ();
extern bool_t xdr_file_bundle_req ();
extern bool_t xdr_reg_bundle_req ();
extern bool_t xdr_poll_bundle_req ();
extern bool_t xdr_info_bundle_req ();

#endif /* K&R C */

#ifdef __cplusplus
}
#endif

#endif /* !_BUNDLE_COMMON_H_RPCGEN */