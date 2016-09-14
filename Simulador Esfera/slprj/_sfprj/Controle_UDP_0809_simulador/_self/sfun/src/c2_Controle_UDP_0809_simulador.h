#ifndef __c2_Controle_UDP_0809_simulador_h__
#define __c2_Controle_UDP_0809_simulador_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc2_Controle_UDP_0809_simuladorInstanceStruct
#define typedef_SFc2_Controle_UDP_0809_simuladorInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c2_sfEvent;
  boolean_T c2_isStable;
  boolean_T c2_doneDoubleBufferReInit;
  uint8_T c2_is_active_c2_Controle_UDP_0809_simulador;
} SFc2_Controle_UDP_0809_simuladorInstanceStruct;

#endif                                 /*typedef_SFc2_Controle_UDP_0809_simuladorInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c2_Controle_UDP_0809_simulador_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c2_Controle_UDP_0809_simulador_get_check_sum(mxArray *plhs[]);
extern void c2_Controle_UDP_0809_simulador_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
