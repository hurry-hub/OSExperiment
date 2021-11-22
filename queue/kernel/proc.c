
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                               proc.c
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                                                    Forrest Yu, 2005
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"
#include "string.h"
#include "proc.h"
#include "global.h"

/*======================================================================*
                              schedule
 *======================================================================*/
PUBLIC void schedule()
{
	PROCESS *p;
	int temp_queue = 3;							
	int arrived_num = 0;							//统计到达的进程数
	int queue_three_num = 0;						//统计位于队列三的进程数
	int prior;
	int finished_num = 0;

	for (p = proc_table; p < proc_table + NR_TASKS; p++) {				//统计位于队列三的进程
		if (p->queue == 3) {
			queue_three_num++;
		}
	}
	for (p = proc_table; p < proc_table + NR_TASKS; p++) {				//统计到达的进程
		if (p->arrive == 1) {
			arrived_num++;
		}
	}

	if (queue_three_num == 6 && arrived_num == 6) {			//都位于队列三，时间片轮转
		int i = 0;
		for ( ; i < NR_TASKS; i++) {
			if ((p_proc_ready->arrive == 1) && (p_proc_ready->ticks < 1)) {	//若进程到达且运行完成，完成数加一
				finished_num++;
			} 
			int j = 0;
			do{
				p_proc_ready++;
				if (p_proc_ready > proc_table + NR_TASKS) {					//保证六个进程都被查找一遍
					p_proc_ready = proc_table;
				}
				j++;														//保证找完后退出
			} while((p_proc_ready->arrive == 0) && (j < 6));				//寻找已到达的进程
		}
		i = 0;
		do{
			p_proc_ready->status = WAIT;									//设置为等待态
			p_proc_ready++;
			if (p_proc_ready > proc_table + NR_TASKS) {
					p_proc_ready = proc_table;
			}
			i++;
		} while(!((p_proc_ready->ticks != 0) && (p_proc_ready->arrive == 1)) && (i < 6));	//寻找未完成但到达的进程
		p_proc_ready->status = RUN;											//设置为运行态
	} else {																//寻找队列中最先来、优先级最高的
		int i = 0;
		prior = 0;
		p = p_proc_ready;
		temp_queue = 3;
		for (; i < 6; i++) {
			p++;															//单个队列的优先级抢占
			p->status = RUN;												//设置为运行态
			//disp_str(p->p_name);
			if (p == proc_table + NR_TASKS) {
				p = proc_table;
			}
			if (p->arrive == 0) {											//未到达，跳出循环
				disp_color_str(p->p_name, BRIGHT | MAKE_COLOR(BLACK, RED));
				disp_color_str(" not arrive! ", BRIGHT | MAKE_COLOR(BLACK, RED));
				continue;
			}
			if (p->queue < temp_queue) {									//寻找最小的队列号
				temp_queue = p->queue;
				// disp_str(p->p_name);
				// disp_int(p->queue);
			}
		}
		for (i = 0; i < 6; i++) {
			p++;															//单个队列的优先级抢占
			if (p == proc_table + NR_TASKS) {
				p = proc_table;
			}
			if (p->priority >= prior && p->queue == temp_queue) {				//优先级大的先执行
				prior = p->priority;
				p_proc_ready = p;
			}
		}
		p_proc_ready->status = RUN;											//设置运行态
	}
	if (finished_num == 6) {												//进程全部执行完
	 	disp_color_str("All process finshed!\n", BRIGHT | MAKE_COLOR(BLACK, BLUE));
		while(1){}
	}
	// if (finished_num == 6) {
	// 	disp_color_str("All process finshed!\n", BRIGHT | MAKE_COLOR(BLACK, RED));
	// 	p->queue = 1;
	// 	p->remained_time = QUEUE_ONE_TIME;
	// 	p->ticks = p->priority;
	// }
	// p_proc_ready = proc_table;
}

/*======================================================================*
                           sys_get_ticks
 *======================================================================*/
PUBLIC int sys_get_ticks()
{
	return ticks;
}

