/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.analisa;

/**
 *
 * @author lenovo
 */
public class BoyerMoore {
    private final int R;
    private int[] right; 
    private String pattern;
    public BoyerMoore (String P)
    {
        R = 256;
        pattern = P.toLowerCase();
        right = new int[R];
        for (int i=0;i<R;i++)
        {
            right[i] = -1;
        }
        for (int i=0;i<pattern.length();i++)
        {
            right[pattern.charAt(i)] = i;
        }
    }
    public int search(String txt)
    {
        String text = txt.toLowerCase();
        int M = pattern.length();
        int N = text.length();
        int skip;
        for (int i = 0; i <= N - M; i += skip) {
            skip = 0;
            for (int j = M-1; j >= 0; j--) {
                if (pattern.charAt(j) != text.charAt(i+j)) {
                    skip = Math.max(1, j - right[text.charAt(i+j)%R]);
                    break;
                }
            }
            if (skip == 0) return i;    // found
        }
        return -1;   
    }
    public boolean match(String txt)
    {
        return (search(txt) != -1);
    }
}
