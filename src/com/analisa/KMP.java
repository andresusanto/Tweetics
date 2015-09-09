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
public class KMP {
    private String pattern;
    private int fail[];
    public KMP(String pat)
    {
        pattern = pat.toLowerCase();
        computeFail();
    }

    public int search(String txt)
    {
        String text = txt.toLowerCase();
        int n = text.length();
        int m = pattern.length();
        int i = 0;
        int j = 0;
        while (i < n)
        {
            if (pattern.charAt(j) == text.charAt(i))
            {
                if ( j == m - 1)
                {
                    return i - m + 1;
                }
                i++;
                j++;
            }
            else if ( j > 0)
            {
                j = fail[j-1];
            }
            else
            {
                i++;
            }
        }
        return -1;
    }
    public boolean match(String txt)
    {
        return (search(txt) != -1);
    }
    private void computeFail()
    {
        fail = new int[pattern.length()];
        fail[0] = 0;
        int m = pattern.length();
        int j = 0;
        int i = 1;
        while ((i < m)&&(j<m))
        {
            if (pattern.charAt(j) == pattern.charAt(i))
            {
                 fail[i] = j + 1;
                 i++;
                 j++;
            }
            else if (j > 0)
            {
                j = fail[j-1];
            }
            else
            {
                fail[i] = 0;
                i++;
            }
        }
    }
}
